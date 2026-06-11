#!/usr/bin/env python3

import argparse
import hashlib
import re
import shlex
import sqlite3
import subprocess
import time
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from zoneinfo import ZoneInfo


REMINDER_RE = re.compile(
    r'@remind\(\s*([^,\)]+)\s*(?:,\s*"([^"]*)")?\s*(?:,\s*"([^"]*)")?\s*\)'
)


@dataclass
class Reminder:
    reminder_id: str
    due_at_utc: str
    title: str
    message: str
    source_path: str
    source_line: int
    raw_line: str


def init_db(db_path: Path) -> None:
    db_path.parent.mkdir(parents=True, exist_ok=True)

    with sqlite3.connect(db_path) as con:
        con.execute("""
            CREATE TABLE IF NOT EXISTS reminders (
                reminder_id TEXT PRIMARY KEY,
                due_at_utc TEXT NOT NULL,
                title TEXT NOT NULL,
                message TEXT NOT NULL,
                source_path TEXT NOT NULL,
                source_line INTEGER NOT NULL,
                raw_line TEXT NOT NULL,
                first_seen_at TEXT NOT NULL,
                last_seen_at TEXT NOT NULL,
                sent_at TEXT
            )
        """)


def parse_local_datetime(value: str, tz: ZoneInfo) -> datetime | None:
    value = value.strip().strip('"').strip("'")

    formats = [
        "%Y-%m-%d %H:%M",
        "%Y-%m-%d %H:%M:%S",
        "%Y-%m-%d",
    ]

    for fmt in formats:
        try:
            dt = datetime.strptime(value, fmt)

            # Date-only reminders default to 09:00.
            if fmt == "%Y-%m-%d":
                dt = dt.replace(hour=9, minute=0)

            return dt.replace(tzinfo=tz)
        except ValueError:
            continue

    return None


def clean_title_from_line(line: str) -> str:
    line = REMINDER_RE.sub("", line)
    line = re.sub(r"^\s*[-*]\s+\[[ xX]\]\s*", "", line)
    line = re.sub(r"^\s*[-*]\s+", "", line)
    line = line.strip()

    return line or "Obsidian reminder"


def make_id(
    source_path: Path,
    line_no: int,
    due_at_utc: str,
    title: str,
    message: str,
) -> str:
    raw = f"{source_path}|{line_no}|{due_at_utc}|{title}|{message}"
    return hashlib.sha256(raw.encode("utf-8")).hexdigest()[:24]


def scan_vault(vault: Path, tz: ZoneInfo) -> list[Reminder]:
    reminders: list[Reminder] = []

    for path in vault.rglob("*.md"):
        rel_path = path.relative_to(vault)

        # Skip hidden folders like .git and .obsidian if desired.
        if any(part.startswith(".") for part in rel_path.parts):
            continue

        try:
            text = path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            continue
        except FileNotFoundError:
            continue

        for line_no, line in enumerate(text.splitlines(), start=1):
            match = REMINDER_RE.search(line)

            if not match:
                continue

            due_raw = match.group(1)
            explicit_title = match.group(2)
            explicit_message = match.group(3)

            due_local = parse_local_datetime(due_raw, tz)

            if due_local is None:
                continue

            due_utc = due_local.astimezone(timezone.utc).isoformat()

            title = explicit_title.strip() if explicit_title else clean_title_from_line(line)
            message = explicit_message.strip() if explicit_message else f"{rel_path}:{line_no}"

            reminder_id = make_id(
                source_path=rel_path,
                line_no=line_no,
                due_at_utc=due_utc,
                title=title,
                message=message,
            )

            reminders.append(Reminder(
                reminder_id=reminder_id,
                due_at_utc=due_utc,
                title=title,
                message=message,
                source_path=str(rel_path),
                source_line=line_no,
                raw_line=line.strip(),
            ))

    return reminders


def upsert_reminders(db_path: Path, reminders: list[Reminder]) -> None:
    now = datetime.now(timezone.utc).isoformat()

    with sqlite3.connect(db_path) as con:
        for r in reminders:
            con.execute("""
                INSERT INTO reminders (
                    reminder_id,
                    due_at_utc,
                    title,
                    message,
                    source_path,
                    source_line,
                    raw_line,
                    first_seen_at,
                    last_seen_at,
                    sent_at
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NULL)
                ON CONFLICT(reminder_id) DO UPDATE SET
                    due_at_utc = excluded.due_at_utc,
                    title = excluded.title,
                    message = excluded.message,
                    source_path = excluded.source_path,
                    source_line = excluded.source_line,
                    raw_line = excluded.raw_line,
                    last_seen_at = excluded.last_seen_at
            """, (
                r.reminder_id,
                r.due_at_utc,
                r.title,
                r.message,
                r.source_path,
                r.source_line,
                r.raw_line,
                now,
                now,
            ))


def send_due_reminders(db_path: Path, notify_cmd: list[str]) -> None:
    now = datetime.now(timezone.utc).isoformat()

    with sqlite3.connect(db_path) as con:
        rows = con.execute("""
            SELECT reminder_id, title, message, source_path, source_line
            FROM reminders
            WHERE sent_at IS NULL
              AND due_at_utc <= ?
            ORDER BY due_at_utc ASC
        """, (now,)).fetchall()

        for reminder_id, title, message, source_path, source_line in rows:
            full_message = f"{message}\n\nSource: {source_path}:{source_line}"

            cmd = notify_cmd + [
                "--title", title,
                "--message", full_message,
            ]

            subprocess.run(cmd, check=False)

            con.execute("""
                UPDATE reminders
                SET sent_at = ?
                WHERE reminder_id = ?
            """, (
                datetime.now(timezone.utc).isoformat(),
                reminder_id,
            ))


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--vault", required=True)
    parser.add_argument("--db", default="/var/lib/obsidian-reminders/reminders.sqlite")
    parser.add_argument("--timezone", default="Europe/Copenhagen")
    parser.add_argument("--interval", type=int, default=30)
    parser.add_argument(
        "--notify-cmd",
        required=True,
        help="Command used to send notifications. The scanner appends --title and --message.",
    )

    args = parser.parse_args()

    vault = Path(args.vault).expanduser().resolve()
    db_path = Path(args.db)
    tz = ZoneInfo(args.timezone)
    notify_cmd = shlex.split(args.notify_cmd)

    init_db(db_path)

    while True:
        reminders = scan_vault(vault, tz)
        upsert_reminders(db_path, reminders)
        send_due_reminders(db_path, notify_cmd)
        time.sleep(args.interval)


if __name__ == "__main__":
    main()
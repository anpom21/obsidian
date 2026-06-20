
Obsidian Sync Reminder Server Setup

This note documents how to set up a Debian/Ubuntu-based headless server that:

1. Syncs an Obsidian vault using Obsidian Headless Sync
2. Scans the synced vault for @remind(...) syntax
3. Sends notifications through a local Python notification script
4. Runs everything through systemd

This version uses Obsidian Sync, not Git.

Relevant links:

- [Obsidian Headless Sync documentation](https://obsidian.md/help/sync/headless)
- [Obsidian Headless CLI documentation](https://obsidian.md/help/headless)
- [obsidian-headless GitHub repository](https://github.com/obsidianmd/obsidian-headless)
- [obsidian-headless npm package](https://www.npmjs.com/package/obsidian-headless)

Obsidian Headless is an open-beta command-line client for Obsidian Sync. It can sync vaults without the desktop app and supports continuous syncing via ob sync --continuous. It requires Node.js 22 or later.

  

1. Target architecture

Obsidian desktop / mobile

        ↓

Obsidian Sync remote vault

        ↓

Home server running Obsidian Headless Sync

        ↓

Local synced vault folder

        ↓

Python reminder scanner

        ↓

SQLite reminder state database

        ↓

Python notification script

The reminder scanner should treat the vault as read-only. It should not edit notes or mark reminders as completed inside markdown files. Reminder state is stored separately in SQLite.

  

2. Reminder syntax inside Obsidian

Basic reminder:

- [ ] Call supplier @remind(2026-06-14 09:00)

Reminder with explicit title:

- [ ] Call supplier @remind(2026-06-14 09:00, "Call supplier")

Reminder with title and message:

- [ ] Call supplier @remind(2026-06-14 09:00, "Call supplier", "Ask about actuator quote")

Recommended format:

- [ ] {{VALUE:Title}} @remind({{VALUE:When YYYY-MM-DD HH:mm}}, "{{VALUE:Title}}", "{{VALUE:Message}}")

This works well with a QuickAdd Capture workflow in Obsidian.

  

3. Folder layout

Recommended server layout:

/srv/obsidian/vault

/opt/obsidian-reminders

/var/lib/obsidian-reminders/reminders.sqlite

Create folders:

sudo mkdir -p /srv/obsidian/vault

sudo mkdir -p /opt/obsidian-reminders

sudo mkdir -p /var/lib/obsidian-reminders

Optional dedicated user:

sudo useradd --system --create-home --shell /bin/bash obsidian

sudo chown -R obsidian:obsidian /srv/obsidian

sudo chown -R obsidian:obsidian /opt/obsidian-reminders

sudo chown -R obsidian:obsidian /var/lib/obsidian-reminders

If using root for a quick setup, set User=root in the service files instead.

  

4. Install Node.js 22

Obsidian Headless requires Node.js 22 or later.

Check the current version:

node --version

If it is older than v22, install Node.js 22 via NodeSource:

sudo apt update

sudo apt install -y ca-certificates curl gnupg

curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -

sudo apt install -y nodejs

Verify:

node --version

npm --version

Expected:

v22.x.x

  

5. Install Obsidian Headless

Install globally:

sudo npm install -g obsidian-headless

Check the executable path:

which ob

ob --help

Common paths:

/usr/bin/ob

/usr/local/bin/ob

Use the actual path from which ob in the systemd service.

  

6. Log in to Obsidian

Run interactively:

ob login

This authenticates the headless client with your Obsidian account. If two-factor authentication is enabled, the CLI should prompt for it.

Check login state:

ob login

If already logged in, it should show account information.

  

7. Set up the synced vault

Use a clean folder that is not also managed by Git.

Example:

sudo mkdir -p /srv/obsidian/vault

sudo chown -R obsidian:obsidian /srv/obsidian

If running as the obsidian user:

sudo -u obsidian -H bash

cd /srv/obsidian/vault

ob sync-setup

If running as root:

cd /srv/obsidian/vault

ob sync-setup

Then do a first manual sync:

ob sync --path /srv/obsidian/vault

Confirm files arrived:

find /srv/obsidian/vault -maxdepth 2 -type f -name "*.md" | head

  

8. Obsidian Sync systemd service

Create:

sudo nano /etc/systemd/system/obsidian-sync.service

Service file:

[Unit]

Description=Obsidian Headless Sync

After=network-online.target

Wants=network-online.target

  

[Service]

Type=simple

User=obsidian

WorkingDirectory=/srv/obsidian/vault

ExecStart=/usr/bin/ob sync --continuous --path /srv/obsidian/vault

Restart=always

RestartSec=10

  

[Install]

WantedBy=multi-user.target

If which ob returned a different path, replace:

ExecStart=/usr/bin/ob sync --continuous --path /srv/obsidian/vault

with the correct path, for example:

ExecStart=/usr/local/bin/ob sync --continuous --path /srv/obsidian/vault

If running everything as root, change:

User=obsidian

to:

User=root

Enable and start:

sudo systemctl daemon-reload

sudo systemctl enable --now obsidian-sync.service

Check logs:

journalctl -u obsidian-sync.service -f

Check status:

systemctl status obsidian-sync.service

  

9. Python dependencies

Install system packages:

sudo apt update

sudo apt install -y python3 python3-venv python3-pip sqlite3

Optional, only if the scanner should understand natural language dates like tomorrow 9am:

sudo apt install -y python3-dateparser

Alternatively:

pip install dateparser

The basic scanner only requires the Python standard library.

  

10. Notification script

Create:

sudo nano /opt/obsidian-reminders/send_notification.py

Example placeholder script:

#!/usr/bin/env python3

  

import argparse

  

  

def send_notification(title: str, message: str) -> None:

    # Replace this with the real notification logic.

    # Examples:

    # - ntfy

    # - Gotify

    # - Pushover

    # - Telegram bot

    # - Home Assistant webhook

    print(f"{title}: {message}")

  

  

def main() -> None:

    parser = argparse.ArgumentParser()

    parser.add_argument("--title", required=True)

    parser.add_argument("--message", required=True)

    args = parser.parse_args()

  

    send_notification(args.title, args.message)

  

  

if __name__ == "__main__":

    main()

Make executable:

sudo chmod +x /opt/obsidian-reminders/send_notification.py

sudo chown obsidian:obsidian /opt/obsidian-reminders/send_notification.py

Test directly:

/usr/bin/python3 /opt/obsidian-reminders/send_notification.py \

  --title "Direct test" \

  --message "This bypasses the Obsidian scanner"

  

11. Reminder scanner script

Create:

sudo nano /opt/obsidian-reminders/reminder.py

Scanner script:

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

  

            if fmt == "%Y-%m-%d":

                dt = dt.replace(hour=9, minute=0)

  

            return dt.replace(tzinfo=tz)

        except ValueError:

            continue

  

    try:

        import dateparser

  

        parsed = dateparser.parse(

            value,

            settings={

                "TIMEZONE": str(tz),

                "RETURN_AS_TIMEZONE_AWARE": True,

                "PREFER_DATES_FROM": "future",

            },

        )

  

        if parsed is None:

            return None

  

        return parsed.astimezone(tz)

    except Exception:

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

Make executable:

sudo chmod +x /opt/obsidian-reminders/reminder.py

sudo chown obsidian:obsidian /opt/obsidian-reminders/reminder.py

  

12. Reminder scanner systemd service

Create:

sudo nano /etc/systemd/system/obsidian-reminders.service

Service file:

[Unit]

Description=Obsidian Reminder Scanner

After=network-online.target obsidian-sync.service

Wants=network-online.target obsidian-sync.service

  

[Service]

Type=simple

User=obsidian

ExecStart=/usr/bin/python3 /opt/obsidian-reminders/reminder.py \

  --vault /srv/obsidian/vault \

  --db /var/lib/obsidian-reminders/reminders.sqlite \

  --timezone Europe/Copenhagen \

  --interval 30 \

  --notify-cmd "/usr/bin/python3 /opt/obsidian-reminders/send_notification.py"

Restart=always

RestartSec=10

  

[Install]

WantedBy=multi-user.target

If running as root, change:

User=obsidian

to:

User=root

Enable and start:

sudo systemctl daemon-reload

sudo systemctl enable --now obsidian-reminders.service

Check logs:

journalctl -u obsidian-reminders.service -f

Check status:

systemctl status obsidian-reminders.service

  

13. Services summary

obsidian-sync.service

Purpose:

Keeps /srv/obsidian/vault continuously synced with Obsidian Sync.

Important command:

/usr/bin/ob sync --continuous --path /srv/obsidian/vault

Useful commands:

sudo systemctl status obsidian-sync.service

sudo systemctl restart obsidian-sync.service

journalctl -u obsidian-sync.service -f

obsidian-reminders.service

Purpose:

Scans the synced vault for @remind(...) lines and sends due notifications.

Important command:

/usr/bin/python3 /opt/obsidian-reminders/reminder.py \

  --vault /srv/obsidian/vault \

  --db /var/lib/obsidian-reminders/reminders.sqlite \

  --timezone Europe/Copenhagen \

  --interval 30 \

  --notify-cmd "/usr/bin/python3 /opt/obsidian-reminders/send_notification.py"

Useful commands:

sudo systemctl status obsidian-reminders.service

sudo systemctl restart obsidian-reminders.service

journalctl -u obsidian-reminders.service -f

  

14. Timers summary

This Obsidian Sync-based setup does not need a systemd timer for syncing.

The sync process runs continuously through:

obsidian-sync.service

The reminder scanner also runs continuously through:

obsidian-reminders.service

So the active units are:

obsidian-sync.service

obsidian-reminders.service

No timer is required.

  

15. Enable everything after edits

Whenever service files are changed:

sudo systemctl daemon-reload

sudo systemctl restart obsidian-sync.service

sudo systemctl restart obsidian-reminders.service

Enable services on boot:

sudo systemctl enable obsidian-sync.service

sudo systemctl enable obsidian-reminders.service

  

16. End-to-end test

Create a test reminder in Obsidian:

- [ ] Test server reminder @remind(2026-06-14 09:00, "Test server reminder", "Created from Obsidian")

Watch Obsidian Sync logs:

journalctl -u obsidian-sync.service -f

Confirm the note reached the server:

grep -R "@remind" /srv/obsidian/vault

Check the SQLite database:

sqlite3 /var/lib/obsidian-reminders/reminders.sqlite \

  "SELECT due_at_utc, title, sent_at, source_path FROM reminders ORDER BY due_at_utc DESC LIMIT 10;"

If sent_at is empty, the reminder has been discovered but not sent yet.

If sent_at contains a timestamp, the notification command was executed.

  

17. Common debugging commands

Check all relevant services:

systemctl status obsidian-sync.service

systemctl status obsidian-reminders.service

Follow logs:

journalctl -u obsidian-sync.service -f

journalctl -u obsidian-reminders.service -f

Check the Obsidian Headless binary:

which ob

ob --help

Check Node:

node --version

Check vault files:

find /srv/obsidian/vault -maxdepth 2 -type f -name "*.md" | head

Check reminders in vault:

grep -R "@remind" /srv/obsidian/vault

Check reminder database:

sqlite3 /var/lib/obsidian-reminders/reminders.sqlite \

  "SELECT due_at_utc, title, sent_at, source_path, source_line FROM reminders ORDER BY due_at_utc DESC LIMIT 20;"

  

18. Notes and caveats

- Obsidian Headless requires an active Obsidian Sync setup.
- Node.js must be version 22 or later.
- Do not run Git sync and Obsidian Headless Sync against the same folder.
- The reminder scanner is read-only toward the vault.
- The scanner stores state in SQLite at:

/var/lib/obsidian-reminders/reminders.sqlite

- If a reminder is created on mobile or desktop but has not synced yet, the server cannot see it.
- The reminder is only as timely as the Obsidian Sync propagation plus the scanner interval.
- The scanner interval is configured with:

--interval 30

This means it checks every 30 seconds.

  

19. Minimal command checklist

sudo apt update

sudo apt install -y ca-certificates curl gnupg python3 python3-pip python3-venv sqlite3

curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -

sudo apt install -y nodejs

sudo npm install -g obsidian-headless

  

sudo useradd --system --create-home --shell /bin/bash obsidian

sudo mkdir -p /srv/obsidian/vault /opt/obsidian-reminders /var/lib/obsidian-reminders

sudo chown -R obsidian:obsidian /srv/obsidian /opt/obsidian-reminders /var/lib/obsidian-reminders

  

sudo -u obsidian -H ob login

sudo -u obsidian -H bash -c "cd /srv/obsidian/vault && ob sync-setup"

sudo -u obsidian -H ob sync --path /srv/obsidian/vault

  

sudo systemctl daemon-reload

sudo systemctl enable --now obsidian-sync.service

sudo systemctl enable --now obsidian-reminders.service

Remember to create these files before enabling the services:

/opt/obsidian-reminders/reminder.py

/opt/obsidian-reminders/send_notification.py

/etc/systemd/system/obsidian-sync.service

/etc/systemd/system/obsidian-reminders.service
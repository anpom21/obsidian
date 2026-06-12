---
tags:
  - dashboard
  - weekly
  - rolling-review
created: 11-06-2026
---

# Rolling Weekly Dashboard
> Rolling overview of the last 7 daily notes.

---

## Last 7 daily notes

```dataviewjs
const DAILY_FOLDER = "Daily";
const DATE_FORMAT = "yyyy-MM-dd";

// Today + previous 6 days = rolling 7-day window
const today = dv.luxon.DateTime.now().startOf("day");
const days = Array.from({ length: 7 }, (_, i) => today.minus({ days: i })).reverse();

for (const day of days) {
  const fileName = day.toFormat(DATE_FORMAT);
  const path = `${DAILY_FOLDER}/${fileName}.md`;
  const file = app.vault.getAbstractFileByPath(path);
  const readableDate = day.toFormat("cccc, dd LLL yyyy");

  if (!file) {
    dv.header(2, `📅 ${readableDate}`);
    dv.paragraph(`_No daily note found for ${fileName}._`);
    continue;
  }

  dv.header(2, `📅 ${readableDate}`);
  dv.paragraph(dv.fileLink(path.replace(".md", ""), false, "Open daily note"));

  let content = await app.vault.read(file);

  // Remove YAML frontmatter
  content = content.replace(/^---\n[\s\S]*?\n---\n?/, "");

  // Remove a top-level date heading if your daily note starts with "# YYYY-MM-DD"
  content = content.replace(new RegExp(`^#\\s+${fileName}\\s*\\n+`), "");

  content = content.trim();

  if (!content) {
    dv.paragraph("_Empty daily note._");
  } else {
    dv.paragraph(content);
  }
}
```

---

## Open tasks from the last 7 days

```dataviewjs
const DAILY_FOLDER = "Daily";
const today = dv.luxon.DateTime.now().startOf("day");
const start = today.minus({ days: 6 });

const pages = dv.pages(`"${DAILY_FOLDER}"`)
  .where(p => p.file.day && p.file.day >= start && p.file.day <= today)
  .sort(p => p.file.day, "asc");

const tasks = pages.file.tasks
  .where(t => !t.completed)
  .sort(t => t.path, "asc");

if (tasks.length === 0) {
  dv.paragraph("_No open tasks in the last 7 days._");
} else {
  dv.taskList(tasks, true);
}
```

---

## Weekly reflection

### Wins
- Snakket om løn - bare det at gøre det var fedt.
- Anders var fan af mit arbejde
- Emma er bare for dejlig


### Problems / blockers

### Follow-ups

### Priorities for the next 7 days
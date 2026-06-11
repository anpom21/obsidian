---
tags:
- dashboard
- weekly
- rolling-review  
created: <% tp.date.now("YYYY-MM-DD HH") %>
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
    dv.header(3, `${readableDate}`);
    dv.paragraph(`_No daily note found for ${fileName}._`);
    continue;
  }

  dv.el(
    "h2",
    "",
    {
      cls: "weekly-dashboard-header",
      attr: {
        style: "color: #00E5FF; font-size: 1.8em; font-weight: 800; margin-top: 1.5em; margin-bottom: 0.5em;"
      }
    }
  );

  const headers = document.querySelectorAll(".weekly-dashboard-header");
  const header = headers[headers.length - 1];
  header.innerHTML = `📅 <a href="${path}" class="internal-link">${readableDate}</a>`;

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

### Problems / blockers

### Follow-ups

### Priorities for the next 7 days
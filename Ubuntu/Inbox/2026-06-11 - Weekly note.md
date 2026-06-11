## <%*  
const weekStart = moment().startOf("isoWeek").format("YYYY-MM-DD");  
const weekEnd = moment().endOf("isoWeek").format("YYYY-MM-DD");  
const created = moment().format("YYYY-MM-DD HH:mm");  
-%>

---
tags:
- dashboard
- weekly
- weekly-review  
    created: <% created %>  
    week_start: <% weekStart %>  
    week_end: <% weekEnd %>
---

# Weekly Dashboard

> Overview of daily notes from **<% weekStart %>** to **<% weekEnd %>**.

---

## Daily notes for this week

```dataviewjs
const DAILY_FOLDER = "Daily";
const DATE_FORMAT = "yyyy-MM-dd";

function parseDate(value) {
  if (!value) return null;
  if (value.toISODate) return value.startOf("day");
  return dv.luxon.DateTime.fromISO(String(value)).startOf("day");
}

const start = parseDate(dv.current().week_start);
const end = parseDate(dv.current().week_end);

if (!start || !end || !start.isValid || !end.isValid) {
  dv.paragraph("⚠️ Missing or invalid `week_start` / `week_end` in frontmatter.");
} else {
  const days = [];
  let cursor = start;

  while (cursor <= end) {
    days.push(cursor);
    cursor = cursor.plus({ days: 1 });
  }

  for (const day of days) {
    const fileName = day.toFormat(DATE_FORMAT);
    const path = `${DAILY_FOLDER}/${fileName}.md`;
    const file = app.vault.getAbstractFileByPath(path);
    const readableDate = day.toFormat("cccc, dd LLL yyyy");

    if (!file) {
      dv.el(
        "h2",
        `📅 ${readableDate}`,
        {
          cls: "weekly-dashboard-header",
          attr: {
            style: "color: #888; font-size: 1.5em; font-weight: 700; margin-top: 1.5em; margin-bottom: 0.5em;"
          }
        }
      );

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
}
```

---

## Open tasks for this week

```dataviewjs
const DAILY_FOLDER = "Daily";

function parseDate(value) {
  if (!value) return null;
  if (value.toISODate) return value.startOf("day");
  return dv.luxon.DateTime.fromISO(String(value)).startOf("day");
}

const start = parseDate(dv.current().week_start);
const end = parseDate(dv.current().week_end);

if (!start || !end || !start.isValid || !end.isValid) {
  dv.paragraph("⚠️ Missing or invalid `week_start` / `week_end` in frontmatter.");
} else {
  const pages = dv.pages(`"${DAILY_FOLDER}"`)
    .where(p => p.file.day && p.file.day >= start && p.file.day <= end)
    .sort(p => p.file.day, "asc");

  const tasks = pages.file.tasks
    .where(t => !t.completed)
    .sort(t => t.path, "asc");

  if (tasks.length === 0) {
    dv.paragraph("_No open tasks in this week’s daily notes._");
  } else {
    dv.taskList(tasks, true);
  }
}
```

---

## Completed tasks for this week

```dataviewjs
const DAILY_FOLDER = "Daily";

function parseDate(value) {
  if (!value) return null;
  if (value.toISODate) return value.startOf("day");
  return dv.luxon.DateTime.fromISO(String(value)).startOf("day");
}

const start = parseDate(dv.current().week_start);
const end = parseDate(dv.current().week_end);

if (!start || !end || !start.isValid || !end.isValid) {
  dv.paragraph("⚠️ Missing or invalid `week_start` / `week_end` in frontmatter.");
} else {
  const pages = dv.pages(`"${DAILY_FOLDER}"`)
    .where(p => p.file.day && p.file.day >= start && p.file.day <= end)
    .sort(p => p.file.day, "asc");

  const tasks = pages.file.tasks
    .where(t => t.completed)
    .sort(t => t.path, "asc");

  if (tasks.length === 0) {
    dv.paragraph("_No completed tasks in this week’s daily notes._");
  } else {
    dv.taskList(tasks, true);
  }
}
```

---

## Weekly reflection

### Wins

### Problems / blockers

### Follow-ups

### Priorities for next week
---
name: obsidian-cli-basic
description: Search, read, and write notes in an Obsidian vault using the official Obsidian CLI.
---


# Obsidian CLI Basic Skill

Use the `obsidian` command to search, read, create, and edit notes in an Obsidian vault.

## Preconditions

* Obsidian CLI must be installed and available as `obsidian`.
* Obsidian must be running, or the first CLI command must be able to launch it.
* Prefer exact `path=` when modifying files.
* Use `file=` only when the note name is unambiguous.
* Use `vault="<vault name>"` as the first parameter if multiple vaults exist.

Example:

```bash
obsidian vault="My Vault" search query="robotics"
```

## Syntax Rules

Parameters use `key=value`.

```bash
obsidian create name="My Note" content="Hello world"
```

Flags are written without values.

```bash
obsidian create name="My Note" content="Hello" open overwrite
```

For multiline content, use `\n`.

```bash
obsidian create name="Meeting Notes" content="# Meeting Notes\n\n- Point 1\n- Point 2"
```

## Search Commands

### Search vault for matching files

Returns matching file paths.

```bash
obsidian search query="search term"
```

Useful options:

```bash
obsidian search query="search term" limit=10
obsidian search query="search term" path="Projects"
obsidian search query="search term" format=json
obsidian search query="search term" total
obsidian search query="Exact Term" case
```

Agent usage:

* Use this first when the user asks to find notes, topics, tags, TODOs, project notes, or references.
* Prefer `limit=10` unless the user asks for exhaustive results.
* Use `format=json` when the result must be parsed programmatically.

### Search with line context

Returns grep-style output: `path:line: text`.

```bash
obsidian search:context query="search term"
```

Useful options:

```bash
obsidian search:context query="TODO"
obsidian search:context query="#important" path="Projects"
obsidian search:context query="robotics" limit=20
obsidian search:context query="robotics" format=json
obsidian search:context query="Robot" case
```

Agent usage:

* Use this when the user asks for specific TODOs, snippets, mentions, definitions, or lines containing a phrase.
* Prefer this over plain `search` when the content around the match matters.

### Open search view

```bash
obsidian search:open query="search term"
```

Agent usage:

* Use only when the user wants the search opened in Obsidian.
* Do not use this for background analysis.

## Read Commands

### Read by note name

```bash
obsidian read file="My Note"
```

### Read by exact path

```bash
obsidian read path="Folder/My Note.md"
```

Agent usage:

* Use `read` after `search` when the user asks for a summary, extraction, rewrite, or detailed answer from a note.
* Prefer `path=` for exactness.

## Write Commands

### Create a new note

```bash
obsidian create name="New Note" content="# New Note\n\nContent here"
```

Create at an exact path:

```bash
obsidian create path="Projects/New Note.md" content="# New Note\n\nContent here"
```

Create from template:

```bash
obsidian create name="Trip Plan" template="Travel"
```


Agent usage:

* Use `create` when the user asks to make a new note.
* Do not use `overwrite` unless the user explicitly asks to replace an existing note.
* Prefer `path=` when creating inside a known folder.

### Append content to a note

```bash
obsidian append path="Projects/My Note.md" content="New line"
```

Append by note name:

```bash
obsidian append file="My Note" content="- [ ] New task"
```

Agent usage:

* Use `append` when adding new information to the end of an existing note.
* Good for logs, notes, todos, meeting notes, and incremental updates.

### Prepend content to a note

Prepends after frontmatter if frontmatter exists.

```bash
obsidian prepend path="Projects/My Note.md" content="Important note"
```


Agent usage:

* Use `prepend` when the user wants something added near the top of a note.
* Useful for status summaries, priority TODOs, warnings, or current context.

## Daily Note Commands

### Read daily note

```bash
obsidian daily:read
```

### Append to daily note

```bash
obsidian daily:append content="- [ ] New task"
```

### Prepend to daily note

```bash
obsidian daily:prepend content="Priority for today"
```

Agent usage:

* Use daily commands when the user says “today”, “daily note”, “journal”, “log this”, or “add this to today”.
* Use `daily:append` for tasks, notes, and logs.
* Use `daily:prepend` for priorities or summaries.

## Safe Agent Workflow

### Finding information

1. Search for candidate files:

```bash
obsidian search query="keyword" limit=10
```

2. If line context is needed:

```bash
obsidian search:context query="keyword" limit=20
```

3. Read relevant files:

```bash
obsidian read path="Exact/Path.md"
```

4. Answer using only the retrieved content.

### Writing information

1. Prefer reading the target file first:

```bash
obsidian read path="Exact/Path.md"
```

2. Choose the safest write operation:

   * New note: `create`
   * Add to end: `append`
   * Add near top: `prepend`
   * Daily note: `daily:append` or `daily:prepend`

3. Don't use destructive flags unless explicitly requested:

   * Never `overwrite`
   * Never `delete`
   * Never `permanent`

## Command Cheat Sheet

```bash
# Help
obsidian help
obsidian help search
obsidian help create

# Search
obsidian search query="meeting notes" limit=10
obsidian search:context query="TODO" limit=20
obsidian search:open query="robotics"

# Read
obsidian read
obsidian read file="My Note"
obsidian read path="Projects/My Note.md"

# Create
obsidian create name="New Note" content="# New Note\n\nContent"
obsidian create path="Projects/New Note.md" content="# New Note\n\nContent"
obsidian create name="From Template" template="Template Name"

# Append
obsidian append path="Projects/My Note.md" content="New content"
obsidian append file="My Note" content="- [ ] New task"

# Prepend
obsidian prepend path="Projects/My Note.md" content="Important context"

# Daily note
obsidian daily
obsidian daily:read
obsidian daily:append content="- [ ] New task"
obsidian daily:prepend content="Priority today"
```

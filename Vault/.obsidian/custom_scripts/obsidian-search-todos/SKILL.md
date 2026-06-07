---
name: obsidian-search-todos
description: Search an Obsidian vault for TODOs using the custom search script and triage #agent and #implement items. Use when user mentions searching todos/tasks, or searching an Obsidian vault, or wants to find #agent tagged items.
---

# Obsidian TODO Search (agent)

## Quick start

Use the script at:

/home/ap/Documents/obsidian/Ubuntu/.obsidian/custom_scripts/search-todos.sh

Default to searching for #agent todos:

./search-todos.sh --tag agent

## Core behavior

- Always include `--tag agent` unless the user explicitly requests different tags.
- If the user provides additional tags, append them: `--tag agent,foo,bar`.
- Use `--note` to scope to notes that mention specific `[[Note]]` links.
- Use `--string` for substring matching and `--case` for case-sensitive matching.
- Use `--all` to include checked items.

## Interpreting results

For each TODO line containing `#agent` (it can appear anywhere on the line):

1. If the line contains `#implement`, treat it as an implementation request.
2. If it is NOT an implementation request and there are no other tags besides `#agent`, answer the question and insert a new bullet directly below the TODO line:

  - Answer: ...

3. If it is NOT an implementation request and other tags are present, ask whether the user wants an answer inserted or a different action.
4. If it is an implementation request:
  - Proceed only when the TODO line or surrounding note text includes an explicit file path that exists in the current workspace, or the user confirms the target is accessible here.
  - Otherwise ask a clarifying question about where the implementation should happen and whether the agent has access to that location.

## Workflow

1. Run the search command with the appropriate filters.
2. For each result line, open the note and locate the matching TODO line.
3. Apply the interpretation rules above.
4. Insert the answer line directly below the TODO if needed.

## Examples

- Find all #agent todos:
  ./search-todos.sh --tag agent

- Find #agent todos mentioning a note link:
  ./search-todos.sh --tag agent --note "Meeting - 11.00"

- Find #agent todos with a substring (case-insensitive):
  ./search-todos.sh --tag agent --string report

- Find #agent todos with a case-sensitive match:
  ./search-todos.sh --tag agent --string "API" --case

- Include checked items:
  ./search-todos.sh --tag agent --all

- Combine tags, note, and string filters:
  ./search-todos.sh --tag agent,work --note Projects --string roadmap

- Search a different vault path:
  ./search-todos.sh --tag agent --vault-path /abs/path/to/vault

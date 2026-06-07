<%*
const now = tp.date.now("YYYYMMDDHHmmss");
const personId = "person-" + now;
-%>
---
id: <% personId %>
type: person
tags:
  - person
aliases:
  - 
relationship: friend
birthday:
anniversary:
partner:
children: []
parents: []
siblings: []
location:
phone:
email:
company:
role:
linkedin:
last_seen:
last_contact:
next_followup:
created:  <% tp.date.now("YYYY-MM-DD") %>

---

# <% tp.file.title %>

## Snapshot
- How we met:
- Known since:
- Relationship:
- Personality:
- Interests:
- Context: friend / family / colleague / neighbor / other

## Family & Relations
- Partner:
- Kids:
- Parents:
- Siblings:

## Important Dates
- Birthday:
- Anniversary:
- Other:

## Work / Professional Context
- Company:
- Role:
- How we work together:
- Current projects:
- Professional interests:

## Favorites
- Food:
- Drinks:
- Hobbies:
- Sports:
- Books/Movies:
- Places:

## Personal Context

### Current Challenges
- 

### Current Goals
- 

### Important Life Events
- 

### Things They Care About
- 

## Life Updates
- 

## Shared Memories
- 

## Gift Ideas
- 

## Things to Ask About
- 

## Timeline

### <% tp.date.now("YYYY") %>
- 

## Related Notes

```dataview
TABLE file.mtime AS Updated
FROM [[]]
WHERE file.name != this.file.name
SORT file.mtime DESC
```
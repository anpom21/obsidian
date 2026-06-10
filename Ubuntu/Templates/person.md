---
id: p-<% tp.date.now("YYYYMMDDHHmmss") %>
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
- Personality:  
- Interests:  
  
## Details  
> [!info]- Family  
> - Partner:  
> - Kids:  
> - Parents:  
> - Siblings:  
  
> [!info]- Work / Professional Context  
> - Company:  
> - Role:  
> - Current projects:  
  
> [!info]- Favorites  
> - Food:  
> - Drinks:  
> - Hobbies:  
> - Books/Movies:  
  
## Personal Context  
%% fold %%  
  
### Current Challenges  
-  
  
### Current Goals  
-  
  
### Important Life Events  
-  
  
### Things They Care About  
-


## Related Notes

```dataview
TABLE file.mtime AS Updated
FROM [[]]
WHERE file.name != this.file.name
SORT file.mtime DESC
```
---
id: p-<% tp.date.now("YYYYMMDDHHmmss") %>
type: person
tags:
  - person
aliases:
  - 
relationship: friend
birthday:
location:
phone:
email:
created: <% tp.date.now("YYYY-MM-DD") %>
---

# <% tp.file.title %>

## Snapshot  
- Personality:  
- Interests:  
  
## Details  
> [!info]- Family  
> - Partner:  
> - Parents:  
> - Siblings:  
  
  
> [!info]- Favorites  
> - Food:  
> - Drinks:  
> - Hobbies:  
> - Books/Movies:  
  
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
---
id: p-<% tp.date.now("YYYYMMDDHHmmss") %>
type: person
tags:
  - person
aliases:
  - 
relationship: friend
birthday:
address:
phone:
email:
created: <% tp.date.now("YYYY-MM-DD") %>
partner:
parents:
siblings:
---
# <% tp.file.title %>
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
> - Interests: 

> [!info]- Notes  
> - Allergies:  
> - ....
  ---
  
## Updates
- 

## Timeline
- 

---
## Related Notes

```dataview
TABLE file.mtime AS Updated
FROM [[]]
WHERE file.name != this.file.name
SORT file.mtime DESC
```
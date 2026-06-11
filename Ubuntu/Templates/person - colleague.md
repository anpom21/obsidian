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
company:
profession:
linkedin:
created: <% tp.date.now("YYYY-MM-DD") %>
partner:
---
# <% tp.file.title %>
## Details 
> [!info]- Nuværende alder: 
> `=date(today)-date(this.birthday)

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
### Current projects

  
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
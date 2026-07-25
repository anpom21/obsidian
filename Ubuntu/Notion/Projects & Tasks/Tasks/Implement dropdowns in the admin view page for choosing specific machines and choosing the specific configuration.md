---
base: "[[Tasks.base]]"
Last edited time: 2025-05-16T09:48:00
Current sprint: false
Assignee:
  - 7a9bee9b-5241-436b-9b1d-7f58eff580bf
Status: Done
Due: 2025-05-07
Priority: High
Project:
  - "[[Notion/Projects & Tasks/Projects/Admin page for upload of models to units|Admin page for upload of models to units]]"
---
Dropdowns are:

- Environment (Two options: Staging (Fierce-wolf) or Production)
- Groups (will need a separate place for creating and assigning units to groups - e.g. creating the ARGO group and then adding to this group all the machines that ARGO currently has - another group could be all wood machines) - selecting a group will select all the units in that group from the list
- Category: (wood, wood-old-impreg, plastic, plastic+pvc etc.)
- Runs (the available training runs for that category of models) - using the API of wandb to fetch available runs
- Mapping
- Thresholds
- Display


---
notion-id: 1c1a52e3-6b64-8038-ac02-f6f9afef61ca
base: "[[Tasks.base]]"
Last edited time: 2025-05-16T09:48:00
Current sprint: false
Assignee:
  - 7a9bee9b-5241-436b-9b1d-7f58eff580bf
Status: Done
Due: 2025-05-07
Priority: High
Project:
  - 1c1a52e3-6b64-80a2-8a57-e7a69525cd6a
---
Dropdowns are:

- Environment (Two options: Staging (Fierce-wolf) or Production)
- Groups (will need a separate place for creating and assigning units to groups - e.g. creating the ARGO group and then adding to this group all the machines that ARGO currently has - another group could be all wood machines) - selecting a group will select all the units in that group from the list
- Category: (wood, wood-old-impreg, plastic, plastic+pvc etc.)
- Runs (the available training runs for that category of models) - using the API of wandb to fetch available runs
- Mapping
- Thresholds
- Display


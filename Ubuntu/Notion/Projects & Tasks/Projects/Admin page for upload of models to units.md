---
base: "[[Projects.base]]"
Owner:
  - 7a9bee9b-5241-436b-9b1d-7f58eff580bf
Status: In Progress
Dates: 2025-04-16
Tasks:
  - "[[Notion/Projects & Tasks/Tasks/Implement an admin view of insights where all machines are are shown in list form with their id (e.g. smoldering-whale) as the first entry|Implement an admin view of insights where all machines are are shown in list form with their id (e.g. smoldering-whale) as the first entry]]"
  - "[[Notion/Projects & Tasks/Tasks/Implement dropdowns in the admin view page for choosing specific machines and choosing the specific configuration|Implement dropdowns in the admin view page for choosing specific machines and choosing the specific configuration]]"
  - "[[Notion/Projects & Tasks/Tasks/Move display-config into and Implement deployment-config|Move display-config into and Implement deployment-config]]"
  - "[[Notion/Projects & Tasks/Tasks/Implement deployment-configs as objects in firebase with versioning, so that each unit can compare versioning of own deployment config to see if a new deployment config is available for the unit|Implement deployment-configs as objects in firebase with versioning, so that each unit can compare versioning of own deployment config to see if a new deployment config is available for the unit]]"
  - "[[Notion/Projects & Tasks/Tasks/Implement a button on the admin page, that when activated takes the choices of the dropdowns and the selected machines and generates new deployment-config files that are then pushed to database bumping the version number|Implement a button on the admin page, that when activated takes the choices of the dropdowns and the selected machines and generates new deployment-config files that are then pushed to database bumping the version number]]"
  - "[[Notion/Projects & Tasks/Tasks/Implement that machines check at specific time (e.g. 2.00 AM) versioning of their own deployment-config file and compare to the version number in the database|Implement that machines check at specific time (e.g. 2.00 AM) versioning of their own deployment-config file and compare to the version number in the database]]"
  - "[[Notion/Projects & Tasks/Tasks/Implement units download if new config and then from the deployment-config read the new model to be downloaded and download this and restart state-machine to load in the new model|Implement units download if new config and then from the deployment-config read the new model to be downloaded and download this and restart state-machine to load in the new model]]"
  - "[[Notion/Projects & Tasks/Tasks/Move default versions of configs to SBC-setup repo (main config and camera config)|Move default versions of configs to SBC-setup repo (main config and camera config)]]"
  - "[[Notion/Projects & Tasks/Tasks/Develop cascading configs for main config and camera config, so that each unit has custom versions of the default configs that they override|Develop cascading configs for main config and camera config, so that each unit has custom versions of the default configs that they override]]"
---
## About this project

- Development of a page on the Admin version of Insights where all machines are listed and models can be uploaded to multiple machines at once


Whiteboard from planning session of this project

Pink drawing shows an outline of the page, all units (currently 16 : 15 production and 1 staging) will be present on this page and selectable like it was an inbox. 

![[1000012491.jpg]]

## Project tasks

<!-- Linked database (not supported by Notion API) -->
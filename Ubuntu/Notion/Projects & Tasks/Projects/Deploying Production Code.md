---
base: "[[Projects.base]]"
Owner:
  - 135d872b-594c-8169-8434-000285f1c45f
Status: Done
Tasks:
  - "[[Notion/Projects & Tasks/Tasks/Setup branches in wade-system Display-develop, Display-staging, Display-production|Setup branches in wade-system Display-develop, Display-staging, Display-production]]"
  - "[[Notion/Projects & Tasks/Tasks/Implement automatic pull of the Display-staging git branch of wade-system if this branch is updated|Implement automatic pull of the Display-staging git branch of wade-system if this branch is updated]]"
  - "[[Notion/Projects & Tasks/Tasks/Implement automatic pull of the Display-production git branch to all units|Implement automatic pull of the Display-production git branch to all units]]"
  - "[[Notion/Projects & Tasks/Tasks/Setup admin-page with view of all units with their unit-id|Setup admin-page with view of all units with their unit-id]]"
  - "[[Notion/Projects & Tasks/Tasks/Include in setup script & setup documentation, that machines are configured to upload to Insights|Include in setup script & setup documentation, that machines are configured to upload to Insights]]"
  - "[[Notion/Projects & Tasks/Tasks/Setup, a test procedure for Fierce-Wolf where it takes x amount of pictures in y timeframe, which can then be used to validate a fully functioning system|Setup, a test procedure for Fierce-Wolf where it takes x amount of pictures in y timeframe, which can then be used to validate a fully functioning system]]"
  - "[[Notion/Projects & Tasks/Tasks/Make versioning system for the config file(s)|Make versioning system for the config file(s)]]"
---
## About this project

This project is for developing an automatic flow for deploying new production code to units.

---

Goal: all units will have 

The flow in GitHub will be:

1. display-develop: this is for testing code on Macs & PC’s before deployinng to Fierce-Wolf
2. display-staging: this is for testing code on Fierce-Wolf before deploying to all units
    1. when merged into this branch, code will automatically be pulled on Fierce-Wolf and a test will commence where Fierce-Wolf will try to take x images in y timeframe
3. display-production: this is the final stage of the flow, where code is ready for all units
    2. when merged into this branch, code will automatically be pulled and services restarted, so the updated code is applied automatically

![[1000012395.jpg]]

## Project tasks

<!-- Linked database (not supported by Notion API) -->

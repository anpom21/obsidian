---
notion-id: 1bba52e3-6b64-802c-8f0b-ed188412b688
base: "[[Projects.base]]"
Owner:
  - 135d872b-594c-8169-8434-000285f1c45f
Status: Done
Tasks:
  - 1bba52e3-6b64-8011-9090-f813a188e178
  - 1bba52e3-6b64-808d-97f8-e5ab19a3bcc8
  - 1bba52e3-6b64-8051-aecd-c37df04d4617
  - 1bba52e3-6b64-8075-bd35-ec98a1ae251e
  - 1bba52e3-6b64-8094-94a6-dba68c043fb2
  - 1bba52e3-6b64-8035-a89b-f402891e33e5
  - 1a0a52e3-6b64-801d-8935-cac3d22ce58d
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

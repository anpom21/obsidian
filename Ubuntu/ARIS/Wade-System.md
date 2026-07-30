---
created: 2026-06-08
tags:
  - "#ARIS"
source:
aliases:
  - WADE
GitHub:
Notion:
path:
---
## Ideas

# [[Tasks]]

- [ ] Update integration tests!!!
	- [ ] Prompt:
	Do a short /grilling-me session on how to improve the integration tests.
	So i want the integration tests to be an end-to-end test. It should run on a folder of deployment configs. And if enabled it should also pull all distinct deployment config from the database, and test each of them. It should assume that each json file in the folder is a deployment config. 
	The folder structure:
```
	aris@fierce-wolf:~/wade-system/wade_system/integration_tests/end-to-end[display-staging]$ tree -d
.
├── deployment_configs
└── images
    ├── background
    ├── dangerous-waste
    ├── mineral-wool
    ├── plastic
    └── wood

```
Assume that the class name is stated within the image name as so:
```
aris@fierce-wolf:~/wade-system/wade_system/integration_tests/end-to-end/images[display-staging]$ tree 
.
├── background
│   ├── background_hard.png
│   ├── background_lamel.png
│   ├── background.png
│   ├── outdoor_wood.png
│   ├── painted_outdoor_wood.png
│   └── soft_plastic.png
├── dangerous_waste
├── mineral_wool
│   ├── background1.png
│   ├── hand1.png
│   ├── plastic_bag_glass_wool_brown1.png
│   ├── plastic_bag_glass_wool_brown2.png
│   ├── plastic_bag_glass_wool_yellow.png
│   └── plastic_bag_stone_wool1.png
├── plastic
└── wood
    ├── background.png
    ├── hand1.png
    ├── outdoor_wood.png
    └── painted_outdoor_wood.png
```
So when classifying if a class name is recognized in the filename then use it to report the performance of the run. If a class name is not recognized then but it in its own category showing the name of the image and the prediction of the image. Each deployment config will have a category and use it to derive which image folder to use for the test. 
The output should be a print out of a table with each row corresponding to a deployment config, with is performance on each of the identified classes, so have a col for each class. Also let it be runnable as a pytest, and let the pytest be marked as complete if all the deployment configs could be ran and completed without errors. If the pytest is run as verbose the test should show the table.
Take inspiration from the current integration test to make this version. See the linked files and familiarize yourself in the repo.

- [ ] Make the run on laptop script open a qt app, where the main window is a web view. And below is one or multiple buttons. Buttons should be centered below the image and the buttons should appear in a row. 
- [ ] 
## Agent description

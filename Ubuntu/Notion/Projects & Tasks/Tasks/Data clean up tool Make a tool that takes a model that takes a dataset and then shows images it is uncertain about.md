---
base: "[[Tasks.base]]"
Last edited time: 2026-07-22T13:37:00
Current sprint: true
Assignee: []
Status: Not Started
Project: []
---

Start a /grilling session about this plan:
Data clean up tool: Make a tool that takes a model that takes a dataset and then shows images it is uncertain about. This could done by looking at:

- Low confidence examples
- High loss
- Misclassifications
- Dissagreement between multiple models - if 2 models disagree about how an image should be classified.

So make sure the tool can take multiple models as input, it should take a folder or csv file as input.
Csv example:

image_path,ground_truth,prediction,conf_background,conf_hands,conf_object
/media/simon/T9/Datasets/Background_dataset_07-2026/Background_true_hard/images/img_bold-eagle_2024-11-20T20-25-08-369.png,background,object,0.09128601849079132,0.3524003028869629,0.5563137531280518
/media/simon/T9/Datasets/Background_dataset_07-2026/Background_true_hard/images/img_brave-panther_2024-10-03T10-31-00-204.png,background,background,0.9567015767097473,0.042729128152132034,0.0005692790728062391
/media/simon/T9/Datasets/Background_dataset_07-2026/Background_true_hard/images/img_brave-panther_2024-10-03T20-15-31-249.png,background,background,0.955525815486908,0.043820418417453766,0.0006537160370498896
/media/simon/T9/Datasets/Background_dataset_07-2026/Background_true_hard/images/img_brave-panther_2025-03-28T13-22-26-578.png,background,background,0.9535576701164246,0.045207954943180084,0.0012343405978754163

Folder structure:
Capture folder structure:


simon@ARISAI:/media/simon/T9/Datasets/Background_dataset_07-2026[main]$ tree -d
.
├── acoustics_panel
│   └── images
├── acrylic
│   ├── annots
│   └── images
├── background
│   └── images
├── background12
│   └── images
├── background23
│   └── images
├── Background_false_hard
│   ├── annots
│   └── images
├── background_happy-elephant
├── background_odense-rennovation
├── Background_true_hard
│   └── images
├── background_with_acrylic
│   └── images
├── basket
│   ├── annots
│   └── images
├── bathing_equipment
│   ├── annots
│   └── images
├── big_electronics
│   ├── annots
│   └── images
├── bike_helmet
├── bike_tire_or_tube
│   ├── annots
│   └── images
├── cardboard
│   ├── annots
│   └── images
├── chemicals_bag
│   ├── annots
│   └── images
├── chemicals_large_rect_plastic
│   ├── annots
│   └── images
├── chemicals_plastic
│   ├── annots

Collection folder structure:

simon@ARISAI:~/Data/Collections_wood$ tree -d
.
├── 2023_week_20-21_happy-elephant
│   ├── acoustics_panel
│   ├── background
│   ├── fence_outdoor
│   ├── floor_tile
│   │   └── annots
│   ├── forest_wood
│   ├── furniture
│   │   ├── annots
│   │   └── images
│   ├── glove
│   ├── hands
│   ├── impregnated_wood
│   │   ├── annots
│   │   └── images
│   ├── impregnated_wood_painted
│   │   ├── annots
│   │   └── images
│   ├── normal_wood
│   │   ├── annots
│   │   └── images
│   ├── normal_wood_painted
│   │   ├── annots
│   │   └── images
│   ├── other
│   ├── outdoor_wood
│   │   ├── annots
│   │   └── images
│   ├── outdoor_wood_painted
│   │   ├── annots
│   │   └── images
│   ├── pallet
│   ├── pallet_collar
│   ├── pallet_outdoor
│   ├── thermo_wood
│   ├── unclear
│   ├── unknown
│   │   ├── annots
│   │   └── images
│   ├── unsure
│   │   └── annots
│   ├── wooden_tool_shaft
│   ├── wood_undefined
│   └── wood_wool_board
├── 2023_week_28-29_happy-elephant
│   ├── acoustics_panel
│   ├── background
│   ├── fence_outdoor
│   ├── floor_tile
│   │   └── annots
│   ├── forest_wood
│   │   └── annots
│   ├── furniture
│   │   ├── annots
│   │   └── images
│   ├── glove
│   ├── hands
│   ├── impregnated_wood
│   │   ├── annots
│   │   └── images
│   ├── impregnated_wood_painted
│   │   ├── annots
│   │   └── images
│   ├── normal_wood
│   │   ├── annots
│   │   └── images
│   ├── normal_wood_painted
│   │   ├── annots
│   │   └── images
│   ├── other
│   ├── outdoor_wood
│   │   ├── annots
│   │   └── images
│   ├── outdoor_wood_painted
│   │   ├── annots
│   │   └── images
│   ├── pallet
│   ├── pallet_collar
│   ├── pallet_outdoor
│   │   └── annots
│   ├── thermo_wood
│   ├── unclear
│   ├── unknown
│   │   ├── annots
│   │   └── images
│   ├── unsure
│   │   └── annots
│   ├── wooden_tool_shaft
│   ├── wood_undefined
│   └── wood_wool_board
├── 2024-10-01_2025-02-13_prod-data_gleaming-tiger
│   ├── acoustics_panel
│   │   ├── annots
│   │   └── images
│   ├── background
│   │   ├── annots
│   │   └── images
│   ├── basket
│   │   ├── annots
│   │   └── images
│   ├── duplicates_do_not_use
│   │   ├── annots
│   │   └── images
│   ├── fence_outdoor
│   │   ├── annots
│   │   └── images
│   ├── floor_tile
│   │   ├── annots
│   │   └── images
│   ├── forest_wood
│   │   ├── annots
│   │   └── images
│   ├── furniture
│   │   ├── annots
│   │   └── images
│   ├── furniture_panel
│   │   ├── annots
│   │   └── images
│   ├── glove
│   │   ├── annots
│   │   └── images
│   ├── hands
│   │   ├── annots
│   │   └── images
│   ├── impregnated_wood
│   │   ├── annots
│   │   └── images
│   ├── impregnated_wood_painted
│   │   ├── annots
│   │   └── images
│   ├── normal_wood
│   │   ├── annots
│   │   └── images
│   ├── normal_wood_painted
│   │   ├── annots
│   │   └── images
│   ├── not_usable_for_train
│   │   ├── annots
│   │   └── images
│   ├── other
│   │   ├── annots
│   │   └── images
│   ├── outdoor_furniture
│   │   ├── annots
│   │   └── images
│   ├── outdoor_wood
│   │   ├── annots
│   │   └── images
│   ├── outdoor_wood_painted
│   │   ├── annots
│   │   └── images
│   ├── pallet
│   │   ├── annots
│   │   └── images
│   ├── pallet_collar
│   │   ├── annots
│   │   └── images
│   ├── pallet_outdoor
│   │   ├── annots
│   │   └── images
│   ├── thermo_wood
│   │   ├── annots
│   │   └── images
│   ├── tool_with_wooden_shaft
│   │   ├── annots
│   │   └── images
│   ├── unclear
│   │   ├── annots
│   │   └── images
│   ├── unsure
│   │   ├── annots
│   │   └── images
│   ├── upholstered_furniture
│   │   ├── annots
│   │   └── images
│   ├── wooden_tool_shaft
│   │   ├── annots
│   │   └── images
│   ├── wood_undefined
│   │   ├── annots
│   │   └── images
│   ├── wood_unknown_painted
│   │   ├── annots
│   │   └── images
│   └── wood_wool_board
│       ├── annots
│       └── images
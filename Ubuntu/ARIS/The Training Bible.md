# The Training Bible

The Training Bible is a complete guide that takes you from newly collected data to a specialized classification model. It's organized into different repositories for each step of the process. For each step, the relevant repository is linked along with helpful scripts for organizing and preparing your data.

# **📝** Table of contents

# **🏁** Getting Started

## Prerequisites

Recommended:

- uv

## How to use this bible

To use this bible as a **quick reference**, use the table of contents and look for **bold** terminal commands. These commands are ready to copy and paste—just update the filepaths to match your context. Other command blocks might be used to showcase a specific folder structure or an example script output.

Any helper scripts used in the bible will be marked with a **different background color** to indicate the level of modification the script will do. They are categorized as so:

- Read only scripts
- File addition scripts
- File moving scripts
- File modification scripts

All scripts shown here will, by default work in a **dry-run mode** meaning they wont make any changes unless told to.

# ⬇️ Start new capture

## Sync data from System Inventory

- Go through [🤖 System Inventory](https://app.notion.com/p/f8235df89274423fb14ea838732ef305?pvs=21)
- Pick a new machine to make a capture for
- Open it and check its **Product History** to determine the start and end date of the capture.
- Run `sync_and_sort.sh` in `christians_helper_scripts`
    - This script will run the 3 scripts below automatically

```bash
bash scripts/sync_and_sort_images.sh --machine <machine> --capture-dir <capture/path> --begin-date <date> --end-date <date>
# Example
bash scripts/sync_and_sort_images.sh --machine daring-leopard --capture-dir /home/simon/Data/Collections_wood/bash_test --begin-date 2025-02-12 --end-date 2025-07-31
```

**If the `sync_and_sort.sh` doesn’t work sync and sort manually**

- Run `sync_images.py` to download images not available on the computer

```bash
python3 scripts/sync_image_files.py --machine <machine> --local-dir <path/to/capture> --begin-date <date> --end-date <date>
# Example
python3 scripts/sync_image_files.py --machine daring-leopard --local-dir /home/simon/Data/Collections_wood/2025-02-12_2025_07_31_EXTRA_daring-leopard --begin-date 2025-02-12 --end-date 2025-07-31
```

Example summary:

```yaml
[INFO] Machine         : daring-leopard
[INFO] Bucket          : aris-platform-dev.appspot.com
[INFO] Remote prefix   : images
[INFO] Local dir       : /home/simon/Data/Collections_wood/2025-02-12_2025_07_31_EXTRA_daring-leopard
[INFO] Collection root : /home/simon/Data/Collections_wood
[INFO] Mode            : DRY-RUN
[INFO] Begin date      : 2025-02-12
[INFO] End date        : 2025-07-31
[INFO] Found 1600 existing files for machine 'daring-leopard' in collection.
[INFO] Found 2445 remote files for machine 'daring-leopard'.
[INFO] 49 files need to be downloaded (missing & within date range).
```

- Run `REAL DOWNLOAD` by providing the `--run` flag
- Build inference records

```bash
python3 scripts/build_inference_records.py --unit <machine> --local-dir <capture/path> --csv-out <path/to/csv>
# Example
python3 scripts/build_inference_records.py --unit daring-leopard --local-dir /home/simon/Data/Collections_wood/2025-02-12_2025-07-31_EXTRA_daring-leopard/ --csv-out /home/simon/Data/Collections_wood/test_folder/bulk_download.csv
```

- Sort images into folders provided by inference records

```bash
python3 sort_images_from_insights.py --images-dir <capture/path> --csv <inference/records/csv/path>
# Example
python3 sort_images_from_insights.py --images-dir /home/simon/Data/Collections_wood/2025-02-12_2025-07-31_EXTRA_daring-leopard/ --csv /home/simon/Data/Collections_wood/2025-02-12_2025-07-31_EXTRA_daring-leopard/bulk_download.csv
```

### Sort capture

## Andreas julenoter

### Navne ændringer af captures

Nedenstående captures har haft meget intetsigende navn, jeg har kigget på hvornår deres tidligste og seneste billeder er blevet taget og har forslået en navneændring. Ved heller ikke om de er sorteret 100% så mapperne skal nok kigges på.

Følgende captures har fået navneændring:

- `gleaming-tiger_01` → `2024-10-01_2025-02-13_prod-data_gleaming-tiger_01_UNSURE`
- `bold_eagle_01` → `2024-12-28_2025-04-07_prod-data_bold-eagle_01_UNSURE`
- `mysterious_owl_01` → `2025-02-12_2025-04-10_prod-data_mysterious_owl_01_UNSURE`

# 🗃️ Organize data

All the files mentioned in this section can be found in the utility script repository [here](http://link.to.utility.script.repo). (The repo is not ready yet, and until then, they can be found on the Simon computer at `/home/simon/Documents/christian_helper_scripts/the_training_bible/Organize_data`. 

Additionally the `tree` apt package is super useful to gather an overview of the structure of a folder.

It can be installed with:

```bash
**sudo apt install tree**
```

Usage:

```bash
# Complete tree structure
**tree**
# Show only directories
**tree -d**
```

### Goal

To begin with, it is assumed that the data is organized into **category folders** in a **data** folder similar to:

```bash
data/
├── category1/
│ 	├── some_long_name.png
│   └── some_image.png
└── category2/
		├── image.png
    └── another_image.png
```

`tree` is useful here to get an overview before continuing. See usage [here](https://app.notion.com/p/The-Training-Bible-2ada52e36b64803a81d1ef9bfe4ea27e?pvs=21).

The goal is to organize it so the data folder becomes a **capture** in a **collection** folder with the background folder named `background`. Additionally, the files should follow the appropriate naming convention. All in all, the folder structure will in the end be organized as follows:

```bash
collection/
└──   capture/
			├── background/
			├── category1/
			│   ├── images/
			│ 	│ 	├── img_<capture-device>_<iso_timestamp1>.png
			│   │   └── img_<capture-device>_<iso_timestamp2>.png
			│   └── annots/
			└── category2/
					├── images/
			  	│ 	├── img_<capture-device>_<iso_timestamp3>.png
					│   └── img_<capture-device>_<iso_timestamp4>.png
					└── annots/
```

### 1.1) Summarize your collected data

It is helpful to gather an overview of your data before beginning to organize it.

Run the helper script `summarise_imgs_and_annots.py`, it will overwrite the categories of the annotation files so it matches the category folder.

```jsx
**python3 summarise_imgs_and_annots.py /path/to/capture_folder**
```

Example output:

```jsx
=== Aggregated Dataset Pairing by Category Name ===
Date: 2025-11-22
Root: /home/ap/Documents/ARIS/Synthetics/tests/test_data

Category                   Image files  Annot files  Unique image keys  Unique annot keys  Missing annots  Missing images
-------------------------------------------------------------------------------------------------------------------------
augmentations_backgrounds  4            0            4                  0                  4               0             
background                 3            0            3                  0                  3               0             
cosmetics                  1            1            1                  1                  0               0             
filled_plastic_bag         3            3            3                  3                  0               0             
foam                       4            4            4                  4                  0               0             
foil_bag_crisps            8            8            8                  8                  0               0             
spray_can                  2            2            2                  2                  0               0             
__TOTALS__                 25           18           21                 18                 3               0  
```

### 1.2) Reorganize files into `annots/` and `images/` folders

The first step is to reorganize files into `annots/` and `images/` folders.

`1_organize_into_images_annots.py` will do just that.

```bash
**python3 1_organize_into_images_annots.py path/to/data**
```

Example scenario:

```bash
jolly_giraffe/
		├── background
		│   ├── annot_jolly-giraffe_2024-11-14T12-36-24-142.json
		│   ├── img_jolly-giraffe_2024-11-14T12-35-46-485.png
		│   └── img_jolly-giraffe_2024-11-14T12-36-24-142.png
		├── flamingo
		│   ├── img_jolly-giraffe_2024-11-08T10-03-05-569.png
		│   └── annot_jolly-giraffe_2024-11-08T10-03-05-569.json
		└── hard_plastic
		    ├── img_jolly_giraffe_2024-04-23T16-03-38-795.png
		    └── img_jolly_giraffe_2024-04-23T18-19-37-525.png
```

Will turn into:

```bash
jolly_giraffe/
		├── background
		│   ├── annots
		│		│   └── annot_jolly-giraffe_2024-11-14T12-36-24-142.json
		│   └── images
		│		    ├── img_jolly-giraffe_2024-11-14T12-35-46-485.png
		│ 	    └── img_jolly-giraffe_2024-11-14T12-36-24-142.png
		├── flamingo
		│   ├── annots
		│		│   └── annot_jolly-giraffe_2024-11-08T10-03-05-569.json
		│   └── images
		│		    └── img_jolly-giraffe_2024-11-08T10-03-05-569.png
		└── hard_plastic
				├── annots
				└── images
						├── img_jolly_giraffe_2024-04-23T16-03-38-795.png
						└── img_jolly_giraffe_2024-04-23T18-19-37-525.png
```

### 1.3) Fix the naming convention of images

If the files don’t have the appropriate naming convention with:

`img_<capture-name>_<iso_timestamp>.png`

The helper script `2_rename_files.py` will rename any image or annotation files to the desired convention, given that the **timestamp is in the filename**. 

```bash
# Dry run (no actual changes)
**python3 2_rename_timestamps.py /path/to/capture

#** Apply changes
**python3 2_rename_timestamps.py /path/to/capture --fix**
```

The script works for the following timestamp patterns:

- Unix: `any_filename_1234567890.123.ext`
    - Eg: `image_1763294332.png` → `img_jolly-giraffe_2025-11-16T12-58-52-000.png`
- YYYYMMDD: `any_filename_20231005_151615.ext`
    - Eg: `image_20231005_151606.png` → `img_jolly-giraffe_2023-10-05T15-16-06-000.png`

### 1.4) Validate data structure

As a final validation step, you can run `3_validate_data_structure.py` to validate the folder structure and the filename convention. 

```bash
**python3 3_validate_data_structure.py /path/to/capture**
```

The script can also be applied to whole collections.

**How it works:**

The script will check for: 

- Correct filename
    - The `capture-name` is not necessarily the same as the `capture` folder name, but it is checked whether the `capture-name` exists in the `capture` folder name.
    - Examples
        - `img_<capture-name>_<iso_timestamp>.png`
        - `annot_<capture-name>_<iso_timestamp>.json`
- Folder structure
    - Assumes the structure seen below

```bash
collection/
└── capture/
			├── background/
			├── category1/
			│   ├── images/
			│ 	│ 	├── img_<capture-name>_<iso_timestamp1>.png
			│   │   └── img_<capture-name>_<iso_timestamp2>.png
			│   └── annots/
			│ 	  	├── annot_<capture-name>_<iso_timestamp1>.json
			│       └── annot_<capture-name>_<iso_timestamp2>.json
			└── category2/
					├── images/
			  	│ 	├── img_<capture-name>_<iso_timestamp3>.png
					│   └── img_<capture-name>_<iso_timestamp4>.png
					└── annots/
			  	  	├── annot_<capture-name>_<iso_timestamp3>.json
			        └── annot_<capture-name>_<iso_timestamp4>.json
```

If the script gives any errors or warnings, read them through and consider fixing them, as they might cause problems downstream. You can also manually check using `tree`. See `tree` usage [here](https://app.notion.com/p/The-Training-Bible-2ada52e36b64803a81d1ef9bfe4ea27e?pvs=21).

# 🖍️ Annotate data

To annotate the acquired data, it is assumed that an `Annotation` repository is ready to be used, and the user has a rough idea of how to use it. Installation and documentation of the repository can be found [here](https://app.notion.com/p/Annotation-2a0a52e36b64801681acf48095c53233?pvs=21). 

Make sure to source the virtual environment before running the annotation tool:

```bash
**source .venv/bin/activate**
```

## 2.1) Auto-segment

It is recommended to use an auto-segmenter on unannotated images first to get an initial segmentation draft. There are different auto-segmentation methods, and the best one for your use case might differ. An overview of the available segmentation methods can be found [here](https://app.notion.com/p/Annotation-2a0a52e36b64801681acf48095c53233?pvs=21). A general-purpose segmentation model is the Segment Anything Model (SAM), which is recommended if you are unsure which one you should use.

### Auto SAM

The auto SAM method is a general-purpose segmentation method that can be chosen with the `--sam` flag. If you should wish to use the method on a **capture folder** instead of an **category folder,** you can use the `--capture_folder` to signal this. If you are working with a fresh batch of data, this flag can speed up the auto-segmentation process. Here is how it would be used in practice:

```bash
**python3 segment.py --sam --capture_folder -d /path/to/capture_folder**
```

This is the simplest way to run **AutoSAM.** This way it will assume that the background folder is at `/path/to/capture_folder/background`. If you want to configure another background folder path you can use the `-b` flag.

If the Auto SAM was successful, you should see something like:

```
---------------------------------------------------------------------------------
      SUCCESS  Completed auto capture segmentation for all category folders.  
---------------------------------------------------------------------------------
**Completed**: capture | 100.00%
**Processed Files**: 41
**Time**  : 60.01 seconds
**Images**: 41
**Annots**: 41
```

**Automated Segmentation**

**Neural Network Segmentation**

**Wood SAM**

## 2.2) Manual segmentation

```bash
**python3 segment.py --man -d /path/to/category_folder**
```

After running an auto-segmentation method, the produced annotations should be reviewed and corrected through manual segmentation. Use the `--man` flag to use the manual segmentation method and review one **category folder** at a time.

When the tool is opened, it will look like the figure below.

![[image.png]]
The manual segmentation tool.

Further utilization of the manual segmenter is explained in the Annotation [repository](https://github.com/ARIS-Robotics/Annotation/blob/dev/docs/overview.md#manual-segmentation-tool).

Once you've examined all the segmentations, you can continue to the next section where they will be reviewed.

## 2.3) Ensure the annotations have the correct categories

Run the helper script `fix_category_annotations.py`, which will overwrite the categories of the annotation files so they match the category folder. The script is a part of the helper script repository.

```jsx
**python3 fix_category_annotations.py /path/to/capture_folder**
```

The script will give a summary of the annotations in the collections folder. Eg.:

```jsx
...
Summary
-------
Files scanned:        18
Files w/ mismatches:  3
Files changed:        0
Total annotations:    20
Matching categories:  17
Mismatched categories:3

Dry run complete. Re-run with --fix to apply changes.
```

## 2.4) Review segmentations

To review the segmentations, use [fiftyone](https://github.com/voxel51/fiftyone) to get an overview and identify errors. A `review_annotations.py` script is made to simplify the process.

```jsx
**python3 review_annotations.py -d path/to/capture_folder -n <dataset_name>**
```

When the fiftyone interface succesfully opens. Please follow these steps:

1. Enable categories in the interface. 
2. Sort by minimum of 2 instances
    1. A common pitfall is that the auto-segmenter creates small segmentation spots. You can easily check for this here.
3. Review all segmentations to ensure they're clean and only capture the category—not shadows, light glare, or similar artifacts.

**Simple example:**

![image.png](The%20Training%20Bible/image%201.png)
![[image 1.png]]
Here it can be seen that:

- `category` is selected
- `num_detections` is selected
- The **bottom left** image has **2** instances, even though it appears to be only one big object.
- The **top left** and **bottom right** images have poor segmentations and should be marked for correction.

When all the poor samples have been marked, they can be tagged and saved. In the top menu click the tag button. Give the samples a tag name such as `revise`. 

![[image 2.png]]
Finally press `add` and `apply` to save the tags.

![[image 3.png]]
After applying the changes, the site should refresh.

**Close the tab** and **return** to the terminal where you will be asked if you want to save the tagged samples. 

```jsx
Save tagged samples? (y/n)
```

**Press enter**.

Then you will be asked to name the tagged samples. 

If you don’t have a preference, **press enter.**

```bash
Enter bad annotation name to save the dataset (default: 'bad_annots_test_revise'):
```

The filepaths of the tagged samples will be printed and saved.

Finally, a command will be shown if you wish to continue correcting the tagged samples in the manual annotation tool.

```bash
Open files in manual annotation tool with:
python3 segment.py -m -f tagged_samples/bad_annots_test_revise.txt
```

When ready, run the manual segmentation tool with the `-f` flag (from file) to only revise the tagged samples.

```jsx
**python3 segment.py -m -f path/to/tagged_samples**
```

Review the samples again until all the segmentations are satisfactory.

# ✨ Synthesize data

When the desired amount of data has been annotated, it is time to use it to synthesize new data. Make sure a working environment is up and running. If not, it can be installed and configured from the [GitHub](https://github.com/ARIS-Robotics/Synthetics) and further documentation can be found [here](https://app.notion.com/p/Synthetics-2b5a52e36b64807db165ed4aa39f237a?pvs=21). 

It is recommended to run the repository [tests](https://app.notion.com/p/Synthetics-2b5a52e36b64807db165ed4aa39f237a?pvs=21) before continuing to ensure that the repository works as expected. 

Before continuing make sure that you have all the annots you need!! 

## 3.1) Data overview

It can be a good idea to review your annotated data again for an overview. Get an overview of the folder structure with [`tree`](https://app.notion.com/p/The-Training-Bible-2ada52e36b64803a81d1ef9bfe4ea27e?pvs=21).

```bash
**tree -d**
```

Optionally the folder structure and naming convention can be validated with [`3_validate_data_structure.py`](https://app.notion.com/p/The-Training-Bible-2ada52e36b64803a81d1ef9bfe4ea27e?pvs=21).

Make sure to include the `augmentations_backgrounds/` folder in your data folder. So it has the following structure:

```bash
collection/ # Maybe dataset?
└──   capture/
			├── background/
			├── *augmentations_backgrounds/*
			└── category1/
			    ├── images/
					| 	└── img_<capture-name>_<iso_timestamp1>.png
			    └── annots/
			  	  	└── annot_<capture-name>_<iso_timestamp1>.json
```

It can also be convenient to gather and overview of the amount of images and annots per category. 

The `summarise_imgs_and_annots.py` can be used from [here](https://app.notion.com/p/The-Training-Bible-2ada52e36b64803a81d1ef9bfe4ea27e?pvs=21).

```jsx
**python3 summarise_imgs_and_annots.py /path/to/capture_folder**
```

## 3.2) Configure synthetics

The Synthetics repository primary functionality is ran from a [`run.sh`](http://run.sh) bash script. 

If it is the first time running the repository make the bash script runnable.

```bash
**chmod +x run.sh**
```

Run the bash script `run.sh`.

```bash
**./run.sh**
```

This should display a menu like:

```bash
**Welcome to Synthetics**
------------------------
Please choose an option:

0. Quick start (Performs steps 1 - 3) [Flag: -q]
1. Prepare project [Flag: -p]
2. Prepare data [Flag: -d]
3. Synthesize [Flag: -s]

---- Other commands ----
4. Load config [Flag: -l]
5. Help [Flag: -h]

Enter your choice:
```

Press ‘2’ to prepare the data. 

After entering the path to your dataset you should see this print out upon a successful synthetics configuration:

```bash
Using config file path: ./configs/tests_test_data_config.yaml
Using metadata file path: ./metadata/tests_test_data_metadata.json

**Preparing data...**
Preparing data from data folder: tests/test_data/
Created metadata file at ./metadata/tests_test_data_metadata.json
Created config file at ./configs/tests_test_data_config.yaml
Data preparation complete.
```

### Configure your config file.

You can now configure the amount of desired synthetics images for each category among other settings in the `xxx_config.yaml` file. 

See an example config [here](https://app.notion.com/p/Synthetics-2b5a52e36b64807db165ed4aa39f237a?pvs=21):

```yaml
paths:
		source_dir: tests/test_data/
		destination_dir: ./synth_output
		metadata_folder: ./metadata/tests_test_data_metadata.json
criteria:
		num_images: 8000
		num_instances:
		- 1
		max_occlusion:
		- 0.5
		max_iterations: 20
		min_background_coverage:
		- 0.1
		max_background_coverage:
		- 1.0
augmentations:
		instance: true
weights:
		area: null
		background_coverage: null
		category: null
		num_instances: null
		ratio: null
system:
		preview: false
		log_level: INFO
		deterministic: null
		summary: false
		tensorboard: null
categories:
-		name: cosmetics
		image_num: 1000
-		name: filled_plastic_bag
		image_num: 4000
-		name: foam
		image_num: 3000
-		name: foil_bag_crisps
		image_num: 0
-		name: spray_can
		image_num: 0
```

## 3.3) Synthesize

To begin synthesizing new image, use the `run.sh` script again.

```bash
**./run.sh**
```

- When prompted with the menu press ‘4’ to **load the config file**.
- Start the synthetics process by pressing ‘3’.

```bash
**Welcome to Synthetics**
------------------------
Please choose an option:

0. Quick start (Performs steps 1 - 3) [Flag: -q]
1. Prepare project [Flag: -p]
2. Prepare data [Flag: -d]
3. Synthesize [Flag: -s]

---- Other commands ----
4. Load config [Flag: -l]
5. Help [Flag: -h]

Enter your choice:
```

Synthetics will load the config file which will be printed. Ensure that your settings are correct before continuing.

The synthetics process may take a while, so grap a coffee while you wait.

When all the images have been generated you should see the following printout at the end:

```bash
Done!
Generated *n* synthetic images in *x* seconds.
```

## 3.4) Inspect the synthesized images

Before continuing to train the classifier, it is recommended to inspect the generated images.

Either do this manually in the file explorer or use the [`review_annotations.py`](https://app.notion.com/p/The-Training-Bible-2ada52e36b64803a81d1ef9bfe4ea27e?pvs=21) fiftyone script.

```jsx
**python3 review_annotations.py -d path/to/capture_folder -n <dataset_name>**
```

If the images are diverse and look good you can continue to **Classification**.

# **🤖** Classification

For this section, it is assumed that a working `classification` repository is up and running. If `classification`is not currently installed it can be found [here](https://github.com/ARIS-Robotics/classification/). 


## TO DO:

- Can multiple base directories be configured and how?
- See new data idea at the bottom
- Look up how to use the data splitter.

## 4.1) Configure training and validation data

Configure input folders for training and validation. First locate the folder(s) which contain the capture folder(s) that you wish to include in your training.

For example, say you have two collection folders that you wish to import data from:

```jsx
path/to/hard/plastic/collection
										├──2025-10-15_aris-dc_gallant-stag
										└──2025-10-15_aris-dc_smoldering-whale

path/to/another/plastic/collection
										├──2025-10-15_aris-dc_enormous-mouse
										├──2025-10-15_aris-dc_jolly-giraffe
										└──2025-10-15_aris-dc_gallant-stag
```

Then `path/to/hard/plastic/collection` and `path/to/another/plastic/collection` would be your **base directories.**  

 List the capture folders in the `base_dir` that you wish to include in your dataset:

```yaml
#input_folder_mineral_wool.yaml
# Training input folder
train:
	- 2025-10-15_aris-dc_gallant-stag
	- 2025-10-15_aris-dc_smoldering-whale
	- synth
validation:
	- 2025-10-15_aris-dc_enormous-mouse
```

Configure class separation as the example:

```yaml
# class_separation_mineral_wool.yaml
glass_wool:
- glass_wool_brown
- glass_wool_yellow
stone_wool:
- stone_wool
- prob_stone_wool
```

Ensure that the `venv classification` environment is sourced.

```yaml
**source venv_classification/bin/activate**
```

With the previous two configs configured it is time to turn the training and validation folders into data yamls with complete file paths for each file. Run `generate_data_yaml_with_log.py` found in `~/christians_helper_scripts`:

```yaml
**python3 generate_data_yaml_with_log.py \
--base_dir DATASET_DIRECTORY \
--input_folders INPUT_FOLDERS \
--class_separation CLASS_SEPARATION \
--out DATA_YAML_OUTPUT**
```

Example:

```yaml
python3 generate_data_yaml_with_log.py \
--base_dir /home/simon/Data/Collections_mineral_wool \
--input_folders input_folders_TEST_mineral_wool_val.yaml \
--class_separation 'class_separation_mineral_wool_01 copy.yaml'
```

Ensure that the generated `data.yaml` has entries in both `test`, `train` and `valid`.

## 4.2) Configure training

### **Config from data**

Now its time to generate a training config file. For this we are gonna use the `create_config_from_data_yaml.py` script found under `classification/scripts/`. The script will generate a training **config** file and a **dataset** file.

```yaml
**python3 classification/scripts/create_config_from_data_yaml.py \
-f DATA.yaml \
-t tag**
```

Example:

```yaml
python3 classification/scripts/create_config_from_data_yaml.py \
-f /home/simon/Documents/christian_helper_scripts/data_mineral_test.yaml \
-t mineral_wool_test
```

The **config** file and **dataset** file will be saved under `data/configs/<tag>/<date>`. With the following naming convention: `<tag>_<date>_config.yaml`

### Sweep config

Copy the previous sweep config file and change the date. The sweep config files is found under `classification/data/sweep/`. 

```yaml
# Eg:
data/sweep/sweep-config_2025-11-24.json
```

After copying and configuring the `sweep-config`. Make sure to copy the path and paste it into the training config under training, or as seen below:

```yaml
# <tag>_<date>_config.yaml
...
train:
	batch_size: 16
	grad_clip_alg: norm
	grad_clip_val: 0.1
	label_smoothing: 0.01
	learning_rate: 0.0003
	log_every_n_step: 5
	num_epochs: 100
	patience: 15
	sweep_file: **data/sweep/sweep-config_<date>.json   # <---** Change this line!
	val_check_interval: 0.5
	weight_decay: 0.01
```

## 4.3) Start sweep

To start a sweep, use the `sweep.py` script found under `classification/scripts/`.

```yaml
**python3 classification/scripts/sweep.py --config path/to/config.yaml**
```

If you would rather start a single training run:

```yaml
python3 classification/scripts/train.py --config path/to/config.yaml
```

## 4.4) Review training sweep

After starting the training, `wandb` should prompt a few links which will give access to a training overview. 

Example output:

```yaml
...
wandb: Tracking run with wandb version 0.23.0
wandb: Run data is saved locally in **/home/simon/Desktop/classification/wandb/run-20251124_151814-u3uzrwkd**
wandb: Run `**wandb offline**` to turn off syncing.
wandb: Syncing run dulcet-sweep-1
wandb: ⭐️ View project at https://wandb.ai/aris-robotics/tag
wandb: 🧹 View sweep at https://wandb.ai/aris-robotics/tag/sweeps/nuhproxv # <---- Click this one
wandb: 🚀 View run at https://wandb.ai/aris-robotics/tag/runs/u3uzrwkd
...
```

Click the `View sweep` link.

This should open a window with a bunch of training relevant graphs:

![image.png](The%20Training%20Bible/image%204.png)

Where different kinds of metrics can be viewed:

- Val loss
- Val accuracy
- Train loss
- Train accuracy
- Learning rate
- Epoch
    
   ## Idea:
    
    generate input folders.
    
    Generates input folders from the collection dir and auto-completed capture folders.
    
    ```python
    import inquirer
    team = inquirer.list_input
    ```
    
    After inputting the desired capture folders, define synthetic/ training only folders. Choose whether it should be an unselected folder or move one of the selected folders into training only.  
    

# 📊 Evaluation

The evaluation of the classification model will also be based on the [`classification`](https://github.com/ARIS-Robotics/classification/) repository.

The main goal of the evaluation is to generate the following:

- Classification accuracy
- Confusion matrix
- Trace model
- Misclassification overview (?)

## 5.1) Trace model (.ckpt → .pt)

The first step is to trace the model so the model architecture gets baked into the file. This will convert the model from a `.ckpt` to a `.pt` file. The script takes two inputs, the `config.yaml` of the training which keeps the path to the model. The second argument is an image.

As multiple model checkpoints will be made during training it is **very important** that the desired model is reference in the config, as the script will use the config as an interface for the model. 

Before running `trace_from_ckpt.py` found in `classification/helper_scripts/`. 

```bash
**python3 trace_from_ckpt.py --config <path/to/config/yaml> --img <path/to/image>**

# Example:
python3 classification/helper_scripts/trace_from_ckpt.py --config /home/simon/Desktop/classification/data/configs/wood/2025-12-30T12_19/wood_2025-12-30T12_19_config.yaml --img /home/simon/Data/Collections_wood/2024-11-14_arisdc_jolly-giraffe_sorted/normal_wood/images/img_jolly-giraffe_2024-11-14T12-38-41-429.png
```

This will generate the `.pt` file in the `checkpoint` folder where the `.ckpt` is also located. 

## 5.2) Generate model inference record

Next an inference record should be generated of the trace model. This step utilizes the `infer_with_traced_model.py` script, found in `classification/helper_scripts/`. The script can be ran with a few different arguments. The two most important are:

- The config path.
- The csv output path.

If only these two inputs are given, the `data-yaml` and the `.pt` model path will be derived from the config file.

```bash
**python3 classification/helper_scripts/infer_with_traced_model.py \
 --config <path/to/config> \
 --out-csv <path/to/inference_record.csv>**

# Example
python3 classification/helper_scripts/infer_with_traced_model.py \
 --config data/configs/wood/2025-12-30T12_19/wood_2025-12-30T12_19_config.yaml \
 --out-csv 2025-12_Wood_training/out.csv
```

Additional inputs include:

- `--model` path to `.pt` model path.
- `--data-yaml` path to `data.yaml` file.
- `--threshold` define the model confidence threshold for classification (defaults to 0.1).
- `--class-names` Comma-separated class names in the model's output order (defaults to YAML 'valid' mapping keys).
- `--batch-size` Inference batch size (default: 16)
- `--device` CPU/ CUDA (default: CUDA)

## 5.3) Calculate performance metrics

To run evaluation use the `/classification/scripts/evaluation.py` script.

For quick usage:

```python
aris evaluation.py --config path/to/config.yaml
```

Noice! Make sure to fill out the evaluation related fields in the config.

## 5.4) Test on machine

Pick a  test machine such as `fierce-wolf`, upload the model to the machine using `rsync`, and then update a `deployment_config.json` to use the new model. To test the machine the following script can be used to test the machine on some sample images:

```python
bash wade_system/scripts/test_model_on_sample_images.sh --waste-type <type> {mineral_wool|plastic|wood}
```

It will run the state machine and simulate button presses on pictures from the `/home/aris/Pictures/test_images` directory.

[Annotation](https://app.notion.com/p/Annotation-2a0a52e36b64801681acf48095c53233?pvs=21)

[Synthetics](https://app.notion.com/p/Synthetics-2b5a52e36b64807db165ed4aa39f237a?pvs=21)
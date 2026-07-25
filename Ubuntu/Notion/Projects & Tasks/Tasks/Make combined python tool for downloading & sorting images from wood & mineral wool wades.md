---
base: "[[Tasks.base]]"
Last edited time: 2026-07-21T13:42:00
Current sprint: false
Assignee:
  - Andreas Pommerencke
Status: Done
Priority: Medium
Project: []
---
Currently the process is:

1. ✅Run `sync_image_files.py`
    1. Downloads images from insights according to unit and a period specified. Saves into a capture folder (should follow the format with prod_data, unit-id and dates)
        1. Would be really sweet if it can also launch a little probe that ssh’s into the chosen machine and verifies that arent images not uploaded to firebase. 
2. Run `build_inference_records.py`
    2. Downloads the inference records from firebase. Right now only includes one of the user evaluations. Need to be updated to include all the available user evaluations. Philips button on insights (bulk_download) does this already
3. ( Run `sort_images_from_insights.py` )
    3. Depends on whether you want images to be presorted according to the machine evals or user evaluations or not at all. Should read the available user evaluations from the inference record and then prompt the user to chose the order of priority of the evaluations.
4. ✅
5. Use the image-sorter
    4. Sort images into the correct directories to make a gt of each image.
6. Run `update_bulk_download.py`
    5. Updates the inference record for a capture, so the inference record gets a gt column based on the directory each image is placed in. This and the column machine_eval is then later the basis for calculating performance of the unit.

2026-04-04 - Andreas
Test out the bash sync and sort script at `/home/simon/aris-cli/scripts/sync_images/sync_and_sort_images.sh`

Or use `aris sync` to test it out.


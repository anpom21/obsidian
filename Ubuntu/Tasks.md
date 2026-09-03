---
created:
tags:
  - todo
source:
aliases:
---
- [ ] Make excalidraw of classification pipeline and [[Classification]] evaluation logging
  - Answer: Use Templater for the note body/frontmatter and QuickAdd for the filename. For a creation date in every new note, add `created: 2026-06-09` to the relevant template. For notes created through QuickAdd, include `{{DATE:YYYY-MM-DD}}` in the filename or template. Daily Notes already points at `Templates/daily.md`, so that template can carry the date automatically for daily pages.
- [ ] Fix [[Zsh]] terminal bugs #home  🔽 
- [ ] [[aris sync]] make outdoor wood be sorted to impregnated wood by default and indoor wood to normal wood #agent 
- [ ] Make a standardized documentation format #ARIS #Documentation
- [ ] Audit: Make it so the audit can be run from a single audit.py script instead of __main__.py The audit script should be able to take prediction.csv files as input and show direct audit results on that. OR optionally just import the image files and then use a different model to audit the data.  It should be possible to provide n number of models by importing as a comma seperated input to --model-config path/to/model_config.yaml,/path/to/2nd/model_config.yaml. It should also be possible to run the audit on a folder, from which it should discover all the images recursively and discover the correct class for each image based on its parent folder. Example: /home/ap/cloud/ARIS/repositories/classification/outputs/debug/background_hands/2026-08-01/run_10-37-49/evaluation/trained_config.yaml. Predictions: /home/ap/cloud/ARIS/repositories/classification/outputs/debug/background_hands/2026-08-01/run_10-37-49/evaluation/predictions.csv. Image folder: /home/ap/Datasets/Background_Dataset_07-26/train
- [ ] Make model .ckpt files inherit the model configuration such as, normalization, preprocessing, inference on test images, model config, #sandcastle [[Classification]]
- [ ] Add a groundtruth label at the top as well, make it clear what reference directory is used for the image, as its written with small letters. For each image show the category folders found in its reference folder. For each new image follow the marked ground truth category on the left. So if there is a long list of categories the groundtruth category might not be visible when going to a new page fix this so its visible on new pages. #sandcastle [[Classification]] 
- [ ] [[wade-system]] LOGGING universal logger for all repos
- [ ] [[Dangerous waste]] prompt. <5% amfotere overfladeaktive stoffer, nonioniskeoverfladeaktive stoffer
- [ ] Make sure machines are up to date with network monitoring and chezmoi
- [ ] chezmoi: make the production machine auto fill the system key in chezmoi with the active wade service 

# This week
```tasks
# Only tasks that are not done, that is, which begin like this (but without the quotes):
#   '- [ ] ' or
#   '* [ ] ' or
#   '1. [ ] '
# Indented tasks are supported, but only single-line tasks.
not done

# Tasks due today or earlier:
due before next week

# Restrict to at most 100 tasks.
# If you ask Tasks to display many hundreds or thousands of tasks,
# Obsidian's editing performance really slows down.
limit 100

# Group and sort the output:
group by filename
sort by description

# Optionally, ask Tasks to explain how it interpreted this query:
```

# Work tasks
```tasks
not done

# Tags including
tag includes #work

# Restrict to at most 100 tasks.
limit 100

# Group and sort the output:
group by filename
sort by description

```
# Home tasks
```tasks
not done

# Tags including
tag includes #home 

# Restrict to at most 100 tasks.
limit 100

# Group and sort the output:
group by filename
sort by description

```
# Tasks waiting
```tasks
not done

# Tags including
tag includes #agent 

# Restrict to at most 100 tasks.
limit 100

# Group and sort the output:
group by filename
sort by description

```

# All tasks
```tasks
# Only tasks that are not done, that is, which begin like this (but without the quotes):
#   '- [ ] ' or
#   '* [ ] ' or
#   '1. [ ] '
# Indented tasks are supported, but only single-line tasks.
not done

# Tasks due today or earlier:
# due before tomorrow

# Restrict to at most 100 tasks.
# If you ask Tasks to display many hundreds or thousands of tasks,
# Obsidian's editing performance really slows down.
limit 100

# Group and sort the output:
group by filename
sort by description

# Optionally, ask Tasks to explain how it interpreted this query:
```

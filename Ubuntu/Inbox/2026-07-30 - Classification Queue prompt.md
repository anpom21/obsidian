---
created: 2026-06-09
tags:
source:
aliases:
---
Prompt:


Okay so basically i want to make a training queue where the user paste config files into `/home/simon/Desktop/classification/configs/_queue`, the `_queue` folder has a 3 subfolders `succesful`, `failed` and `planning`. If a training run runs without errors it gets moved after the run to `succesful` if not it is moved to `failed`. `planning` can be used to plan new configs, but if the `queue_manager.py` is run then it shouldnt put the planning configs in the queue. 
Config:
```yaml
# @package _global_

defaults:
  - /experiment: debug
  - /data: debug
  - _self_

experiment_name: background_hands

preview:
  enabled: false

hydra:
  run:
    dir: outputs/${fraction}/${experiment_name}/${now:%Y-%m-%d}/run_${now:%H-%M-%S}
  sweep:
    dir: outputs/${fraction}/${experiment_name}/${now:%Y-%m-%d}/multirun_${now:%H-%M-%S}
    subdir: ${hydra.job.num}
```
To run:
```
python3 classification/scripts/train_hydra.py   --config-path /home/simon/Desktop/classification/configs   --config-name _queue/config
```

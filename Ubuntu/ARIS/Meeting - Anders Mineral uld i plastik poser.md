---
created: 2026-06-03
tags:
  - meeting
source: https://app.notion.com/p/aris-robotics/1a8a52e36b6480708d2feb893ce188a8?v=1a8a52e36b6480b091de000c75ec9d80&p=375a52e36b648082bfa1cfbf970e82eb&pm=s
aliases:
location:
start time: 13:00
end time: 14:00
people: anders
date: 2026-06-11
summary:
---

## Mineraluld i poser
![[Mineral wool plastic bag - Overview]]

## Speciale 
![[Speciale - Overview]]


Show new dolphin images
## Dangerous waste
- Biotex
	- 15
- Hærder med brandfarligt piktogram ...
	- 28
- Bromtinktur fejl
	- 35
	- 36

#  Spraydåse
- Spraydåse
- Billede + prompt
	- Forbedre prompt
	- I main prompt husk note


### Særklasse produkter
- Fugemasse
- Spraydåser


Here’s an example of the **fully resolved standalone training config** I’d expect a run to generate, combining the current repo config shape with the newer JSON-inspired dataset structure.

```yaml
experiment_name: mineral_wool_plastic_bag_full_res_mix_aug_all_norm_v3

system:
  seed: 42
  n_cpu_workers: 8
  matmul_precision: high
  verbose: false

trainer:
  accelerator: auto
  devices: 1
  precision: 32
  max_epochs: 100
  min_epochs: 50
  val_check_interval: 0.5
  log_every_n_steps: 5
  gradient_clip_val: 0.1
  gradient_clip_algorithm: norm

model:
  name: resnet18
  pretrained: true
  n_frozen_layers: 7
  dropout: 0.0
  model_path: null

  # Resolved/generated from data.classes keys
  cls_names:
    - glass_wool
    - stone_wool

  # Compatibility mirror of loss.class_weights after resolution
  class_imbalance: auto

  broad_class_names: []
  specific_to_broad_class_mappings: []
  thresholds:
    - 0.72
    - 0.58

train:
  batch_size: 16
  num_epochs: 100
  patience: 15
  monitor_metric: val_loss
  monitor_mode: auto
  preview_augmentations: false

optimizer:
  name: adamw
  learning_rate: 0.0005
  weight_decay: 0.01
  amsgrad: true

scheduler:
  enabled: true
  name: linear_warmup_cosine
  warmup_fraction: 0.5
  cosine_fraction: 0.5
  eta_min: 0.0

loss:
  name: cross_entropy
  label_smoothing: 0.01
  class_weights: auto

logging:
  logger: tensorboard
  tag: mineral_wool_plastic_bag_full_res_mix_aug_all_norm_v3
  version: 0.0.1
  output_dir: null
  tensorboard_dir: null
  checkpoint_dir: null

data:
  # Generated configs should reuse this by default for exact reruns.
  resolved_data_file: null
  resolve_on_rerun: false

  default_real_roots:
    - /home/simon/Desktop/MineralWoolDataset_2026-05

  default_synthetic_roots:
    - /home/simon/Desktop/mw_synth1
    - /home/simon/Desktop/mw_synth2

  discovery:
    recursive: true
    image_extensions:
      - .png
      - .jpg
      - .jpeg

  split:
    strategy: folder
    seed: ${system.seed}
    ratios:
      train: 0.8
      val: 0.2
      test: 0.0

  limits:
    real_per_class: null
    synthetic_per_class: null

  validation:
    allow_missing_subcategories: false
    require_val: true
    duplicate_filename_policy: error
    split_leakage_policy: error

  classes:
    glass_wool:
      real:
        subcategories:
          - glass_wool_brown_plastic_bag
          - glass_wool_plastic_bag
          - glass_wool_yellow_plastic_bag
          - glass_wool
          - glass_wool_brown
          - glass_wool_yellow

      synthetic:
        subcategories:
          - glass_wool_augmented

    stone_wool:
      real:
        subcategories:
          - stone_wool_plastic_bag
          - prob_stone_wool_plastic_bag
          - stone_wool

      synthetic:
        subcategories:
          - stone_wool_augmented

augmentations:
  source_policy:
    use_for_real: true
    use_for_synthetic: true

  mixup:
    enabled: true
    alpha: 0.2
    p: 0.05

  cutmix:
    enabled: true
    alpha: 1.0
    p: 0.3

  resize:
    width: 1200
    height: 1200
    interpolation: 0
    p: 0.0

  random_resized_crop:
    width: 600
    height: 400
    scale:
      min: 0.08
      max: 1.0
    ratio:
      min: 0.9
      max: 1.1
    p: 0.0

  random_rotate_90:
    p: 0.0

  random_shadow:
    num_shadows_limit:
      min: 1
      max: 2
    shadow_dimension: 5
    p: 0.1

  affine:
    shear:
      min: -10
      max: 10
    rotate:
      min: -45
      max: 45
    translate_percent:
      min: -0.15
      max: 0.15
    scale:
      min: 0.8
      max: 1.2
    interpolation: 2
    p: 0.5

  iso_noise:
    color_shift:
      min: 0.01
      max: 0.05
    intensity:
      min: 0.1
      max: 0.5
    p: 0.1

  horizontal_flip:
    p: 0.5

  vertical_flip:
    p: 0.0

  color_jitter:
    hue: 0
    brightness:
      min: 0.8
      max: 1.2
    contrast:
      min: 0.8
      max: 1.2
    saturation:
      min: 0.8
      max: 1.2
    p: 0.25

  gauss_noise:
    std_range:
      min: 0.01
      max: 0.1
    mean_range:
      min: -0.1
      max: 0.1
    p: 0.0

  defocus:
    radius:
      min: 1
      max: 5
    alias_blur:
      min: 0.1
      max: 0.5
    p: 0.0

  brightness_contrast:
    brightness_limit:
      min: -0.2
      max: 0.2
    contrast_limit:
      min: -0.2
      max: 0.2
    p: 0.25

  clahe:
    clip_limit: 2.0
    p: 0.25

  coarse_dropout:
    max_height: 8
    max_width: 8
    num_holes:
      min: 2
      max: 6
    p: 0.1

evaluation:
  ckpt_path: null
  output_dir: null
  inference_record: null
  fraction_dictionary: ./classification/utils/fraction_dictionary.yaml
  report_template_path: ./classification/utils/template_classification_report.md

hydra:
  run:
    dir: runs/${experiment_name}/${now:%Y-%m-%d_%H-%M-%S}
  sweep:
    dir: runs/${experiment_name}/multirun_${now:%Y-%m-%d_%H-%M-%S}
    subdir: ${hydra.job.num}
```

In the actual generated `training_config.yaml`, these would be filled in after resolution:

```yaml
data:
  resolved_data_file: /path/to/run/resolved_data.yaml

logging:
  output_dir: /path/to/run
  tensorboard_dir: /path/to/run/tensorboard
  checkpoint_dir: /path/to/run/checkpoints

model:
  class_imbalance:
    - 0.48902920284135754
    - 0.5109707971586425

loss:
  class_weights:
    - 0.48902920284135754
    - 0.5109707971586425

evaluation:
  output_dir: /path/to/run
```

And the post-training `trained_config.yaml` would additionally set:

```yaml
model:
  model_path: /path/to/run/checkpoints/best.ckpt

evaluation:
  ckpt_path: /path/to/run/checkpoints/best.ckpt
```
---
base: "[[Tasks.base]]"
Last edited time: 2026-07-08T15:25:00
Current sprint: false
Assignee:
  - Andreas Pommerencke
Status: Done
Priority: Medium
Project:
  - "[[Notion/Projects & Tasks/Projects/Model evaluation tracking|Model evaluation tracking]]"
---
# Generate model evaluation manifest with fileserver paths and full classification metrics

## Goal

Create a `model_eval_manifest.yaml` file that describes a completed model evaluation in a standardized way.

This manifest should be generated after evaluation and should contain the information needed to create/update records in Notion and Firebase. It should primarily reference where the evaluated training run and related artifacts can be found on the ARIS fileserver.

The most important field is the fileserver path to the training run folder. The checkpoint, config, dataset file, metrics, and logs are expected to have a consistent structure inside that training run folder.

## Context

Training and evaluation are already under control. This task is only about standardizing the handoff from the evaluation pipeline into the upload/tracking layer.

The broader upload plan has three separate downstream integrations:

- ARIS fileserver upload
- Firebase metadata upload
- Notion model-evaluation table update

This task does not implement those integrations. It only defines and generates the manifest that downstream uploaders will consume.

## Proposed manifest shape

```yaml
run:
# Most important path: canonical location of the full training run on the fileserver.
	fileserver_run_dir: /path/to/fileserver/model_evaluation/mineral_wool/mineral-woolV1.2.1_plastic-bag
	training_machine_run_dir: /home/simon/Desktop/classification/outputs/mineral_wool/mineral_wool_plastic_bag/2026-07-08/run_08-50-48
	
	fraction: mineral-wool
	model_name: efficientnet_b0
	run_name: mineral-woolV1.2.1_plastic-bag
	trained_at: 2026-06-09T14:30:00
	evaluated_at: 2026-06-10T08:24:45
	
	# Key paths
	config_path: /path/to/fileserver/model_evaluation/mineral_wool/mineral-woolV1.2.1_plastic-bag/training_config.yaml
	dataset_yaml_path: /path/to/fileserver/model_evaluation/mineral_wool/mineral-woolV1.2.1_plastic-bag/resolved_data.yaml
	model_path: /path/to/fileserver/model_evaluation/mineral_wool/mineral-woolV1.2.1_plastic-bag/mineral-woolV1.2.1_plastic-bag.pt
	metrics_dir: /path/to/fileserver/model_evaluation/mineral_wool/mineral-woolV1.2.1_plastic-bag/evaluation/performance_metrics
	
time:
	training_time: 1h 15m
	average_inference_time_per_image: 12ms
	training_start: 2026-06-09T14:30:00
	training_end: 2026-06-09T15:45:00
	
data:
  splits:
    train:
    - total: 3838
    - class: glass_wool
      count_real: 634
      count_synth: 1422
      count_total: 2056
    - class: stone_wool
      count_real: 214
      count_synth: 1568
      count_total: 1782

    val:
    - total: 43
    - class: glass_wool
      count: 23
    - class: stone_wool
      count: 20

    test:
    - total: 52
    - class: glass_wool
      count: 28
    - class: stone_wool
      count: 24


evaluation:
  metrics:
    accuracy: 0.94
    f1: 0.93
    macro_accuracy: 0.91
    macro_f1: 0.90

  classification_report:
    classes:
      wood:
        precision: 0.95
        recall: 0.92
        f1: 0.93
        accuracy: 0.94
        support: 120
      plastic:
        precision: 0.91
        recall: 0.89
        f1: 0.90
        accuracy: 0.92
        support: 100
      mineral_wool:
        precision: 0.88
        recall: 0.86
        f1: 0.87
        accuracy: 0.89
        support: 80

    macro_avg:
      precision: 0.91
      recall: 0.89
      f1: 0.90
      accuracy: 0.91
      support: 300

    weighted_avg:
      precision: 0.92
      recall: 0.91
      f1: 0.91
      accuracy: 0.92
      support: 300

  confusion_matrix:
    labels:
      - wood
      - plastic
      - mineral_wool

    # Rows are true labels, columns are predicted labels.
    matrix:
      - [110, 8, 2]
      - [7, 89, 4]
      - [3, 8, 69]
```

## Requirements

The manifest should include:

- Canonical fileserver path to the full training run folder.
- Fileserver path to the selected model checkpoint.
- Fileserver path to the model artifact, if different from the checkpoint.
- Fileserver path to the Hydra/config file.
- Fileserver path to `dataset.yaml`.
- Fileserver path to the metrics file.
- Full top-level evaluation metrics:
    - accuracy
    - f1
    - macro accuracy
    - macro f1
- Full classification report for all classes.
- Per-class metrics, including at minimum:
    - precision
    - recall
    - f1
    - accuracy
    - support
- Data required to recreate the confusion matrix:
    - ordered class labels
    - confusion matrix values
    - convention that rows are true labels and columns are predicted labels

## Important design decision

The manifest should use fileserver paths, not local desktop paths, because this manifest is meant to support Firebase and Notion records after the training run has been uploaded.

The key path is:

```yaml
run:
  fileserver_run_dir: <path to training run folder on fileserver>
```

Other artifact paths may be explicitly included for convenience, but they should be derivable from `fileserver_run_dir` because the internal training-run folder structure is expected to be stable.

## Implementation notes

- Generate the manifest after evaluation has completed.
- The manifest should be based on the evaluated checkpoint and the final evaluation outputs.
- The manifest should not require Notion or Firebase credentials.
- The manifest should not update Notion, Firebase, or the fileserver directly.
- If the evaluation produces a `classification_report` dictionary, serialize it directly into the manifest.
- If the evaluation produces a confusion matrix as a NumPy array or tensor, convert it to a normal nested list before writing YAML.
- Include the ordered list of class labels used for the confusion matrix.
- Make the confusion matrix convention explicit: rows are true labels, columns are predicted labels.

## Acceptance criteria

- A completed evaluation produces a `model_eval_manifest.yaml`.
- The manifest contains a `run.fileserver_run_dir` field.
- The manifest contains fileserver paths for:
    - model/checkpoint
    - config
    - `dataset.yaml`
    - metrics file
    - classification report file, if written separately
    - confusion matrix file, if written separately
- The manifest contains top-level metrics:
    - accuracy
    - f1
    - macro accuracy
    - macro f1
- The manifest contains the full classification report for all evaluated classes.
- The manifest contains all information required to recreate a confusion matrix.
- The manifest can be consumed later by independent uploaders for:
    - Notion
    - Firebase
    - ARIS fileserver tracking
- No Notion API integration is implemented in this task.
- No Firebase integration is implemented in this task.
- No fileserver upload implementation is implemented in this task.

## Out of scope

- Updating Notion tables
- Writing Firebase documents
- Running `rsync` or uploading files to the fileserver
- Designing the Notion dashboard
- Implementing upload retries
- Implementing partial upload status tracking
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
# Upload evaluated training run folder to ARIS fileserver

## Goal

Implement a fileserver upload step that copies a completed training run folder from the local machine to its canonical location on the ARIS fileserver.

This task should make sure that the evaluated model checkpoint, config, dataset file, metrics, classification report, confusion matrix data, logs, and any other relevant run artifacts are available from a stable fileserver path.

The output of this task is the canonical `fileserver_run_dir` path that will later be written into the model evaluation manifest and consumed by the Notion and Firebase upload tasks.

## Context

Training and evaluation already produce a complete local training run folder. The model evaluation manifest should reference fileserver paths, not local desktop paths.

Therefore, before Notion or Firebase upload can be reliable, we need a repeatable way to sync the full evaluated training run folder to the fileserver.

Expected pipeline boundary:

```plain text
local training run folder
  → fileserver upload/sync
  → canonical fileserver training run folder
  → manifest references fileserver paths
  → Notion/Firebase uploaders consume manifest
```

## Proposed approach

Use `rsync` or a similar robust file-copy mechanism to sync the full training run directory to the ARIS fileserver.

Example conceptual command:

```bash
rsync -av --progress \
  /home/aris/runs/wood/2026-06-09_14-30-00/0_model.lr=0.001,batch=32/ \
  /mnt/aris-fileserver/ml/runs/wood/2026-06-09_14-30-00/0_model.lr=0.001,batch=32/
```

The final implementation can wrap this in Python or a shell script, but the behavior should be explicit and easy to inspect.

## Required inputs

The upload step should take:

```yaml
local_run_dir: /home/aris/runs/wood/2026-06-09_14-30-00/0_model.lr=0.001,batch=32
fileserver_run_dir: /mnt/aris-fileserver/ml/runs/wood/2026-06-09_14-30-00/0_model.lr=0.001,batch=32
```

The `fileserver_run_dir` should preserve the same logical structure as the local run folder, including material/category, timestamp, and run name.

## Files that must be present after upload

At minimum, the fileserver run folder should contain:

```plain text
fileserver_run_dir/
  .hydra/
    config.yaml
    hydra.yaml
    overrides.yaml

  checkpoints/
    last.ckpt
    <selected-best-checkpoint>.ckpt

  logs/
    metrics.json
    classification_report.json
    confusion_matrix.json
    tensorboard/

  dataset.yaml
  model_eval_manifest.yaml
```

The exact set of files can grow later, but these should be treated as the required minimum for downstream tracking.

## Implementation notes

- Prefer syncing the entire run folder instead of copying individual files one-by-one.
- Preserve the internal folder structure of the training run.
- The task should fail clearly if the local run folder does not exist.
- The task should create the destination folder on the fileserver if needed.
- The task should verify that required files exist after upload.
- The task should not update Notion.
- The task should not write to Firebase.
- The task should not decide evaluation metrics.
- The task should only make the run artifacts available on the fileserver and return/record the final fileserver path.

## Validation

After syncing, validate that the following files exist on the fileserver:

- `.hydra/config.yaml`
- `dataset.yaml`
- selected checkpoint
- `logs/metrics.json`
- `logs/classification_report.json`
- `logs/confusion_matrix.json`
- `model_eval_manifest.yaml`

If any required file is missing, the task should report a clear error.

## Acceptance criteria

- Given a local evaluated training run folder, the task uploads/syncs it to the ARIS fileserver.
- The destination path preserves the canonical training-run structure.
- The upload uses `rsync` or a similarly robust mechanism.
- The uploaded fileserver folder contains configs, dataset file, checkpoint, metrics, classification report, confusion matrix data, logs, and manifest.
- The task validates that required files exist after upload.
- The task outputs the canonical `fileserver_run_dir`.
- The resulting `fileserver_run_dir` can be used directly in the model evaluation manifest.
- No Notion API logic is implemented.
- No Firebase upload logic is implemented.

## Out of scope

- Creating or updating Notion table rows
- Creating or updating Firebase documents
- Designing the model overview dashboard
- Computing evaluation metrics
- Generating the classification report
- Generating confusion matrix data
- Training or evaluating the model
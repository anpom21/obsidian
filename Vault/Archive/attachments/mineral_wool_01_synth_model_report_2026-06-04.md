# Classification Report
**Created at:** 2026-06-04T09:58

**Tag:** mineral_wool_01_synth

## Dataset:
### Dataset summary:

| Split | Count | Share of overall |
|-------|-------|------------------|
| train                | 3807                 | 97.97%               |
| validation           | 79                   | 2.03%                |
| TOTAL                | 3886                 | 100.00%              |

| Class             | Count (train) | Share of train | Count (validation) | Share of validation |
|------------------|---------------|----------------|--------------------|----------------------|
| glass_wool           | 2056                 | 8.73%                | 46                   | 58.23%               |
| stone_wool           | 1751                 | 7.44%                | 33                   | 41.77%               |
| TOTAL                | 3807                 | 16.17%               | 79                   | 100.00%              |

#### Real vs. synthetic training split:



| Class             | Count (train, real) | Share of train (real) | Count (train, synthetic) | Share of train (synthetic) |
|------------------|---------------------|-----------------------|--------------------------|----------------------------|
| glass_wool           | 2056                 | 100.00%              | 0                    | 0.00%                |
| stone_wool           | 1751                 | 100.00%              | 0                    | 0.00%                |
| total                | 3807                 | 100.00%              | 0                    | 0.00%                |


#### Data file path:
[Data file](data.yaml) 



## Model:

### Model architecture:
| Component | Description |
|-----------------|-----------------|
| Backbone             | resnet18             |
| Number of frozen layers | 7                    |
| Pretrained           | True                 |

### Training configuration:
| Hyperparameter | Value |
|----------------|-------|
| Batch size           | 16                   |
| Learning rate        | 0.0005               |
| Weight decay         | 0.01                 |
| Epochs               | 100                  |
| Device               | cuda                 |
| Number of CPU workers | 8                    |
| Image size           | 1920x1200            |


### Training plots:
#### Training/ validation loss:
![Training and Validation Loss](performance_metrics/training_val_loss.png)


#### Training/ validation accuracy:
![Training and Validation Accuracy](performance_metrics/training_val_acc.png)


### Model path:
[Model path](model_classification2.2.2_mineral_wool_01_synth0.1.1_epoch=50_val_loss=0.03_val_acc=0.91.pt)

## Evaluation:
### Confusion matrix:
![Confusion Matrix (Simple)](performance_metrics/confusion_matrix_simple.png)

![Confusion Matrix (Fancy)](performance_metrics/confusion_matrix_fancy.png)

Confidence thresholds: 
### Classification report:

#### Overall metrics:
| Overall Metrics | Value |
|-----------------|-------|
| Accuracy             | 0.911                |
| Precision            | 0.947                |
| Recall               | 0.911                |
| F1 Score             | 0.929                |

#### Per-Class Metrics 

| Class             | Precision | Recall | F1-Score | Support |
|------------------|-----------|--------|----------|---------|
|   glass_wool         | 0.96                 | 0.93                 | 0.95                 | 46                   |
|   stone_wool         | 0.94                 | 0.88                 | 0.91                 | 33                   |
|       Unsure         | 0.00                 | 0.00                 | 0.00                 | 0                    |
|                      |                      |                      |                      |                      |
| accuracy             |                      |                      | 0.91                 |                      |
|    macro avg         | 0.63                 | 0.60                 | 0.62                 | 79                   |
| weighted avg         | 0.95                 | 0.91                 | 0.93                 | 79                   |


### Misclassifications:


## Source files:
## Source files:
- [Configuration file](config.yaml)
- [Data file](data.yaml)
- [Model file](model_classification2.2.2_mineral_wool_01_synth0.1.1_epoch=50_val_loss=0.03_val_acc=0.91.pt)
- [Inference Record CSV](predictions.csv)
- [Evaluation metrics and plots](performance_metrics)

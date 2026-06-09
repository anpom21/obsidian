---
created: 2026-06-08
tags:
  - "#ARIS"
source:
aliases:
GitHub:
Notion:
path:
---
## Ideas
- Use hydra to organize configs
- Use tensorboard to write logging messages
- Use pytorch to write checkpoints 
### Example

### Training run management
```
runs/  
	wood/  
		2026-06-09_14-30-00/  
			0_model.lr=0.001,batch=32/  
				.hydra/  
					config.yaml  
					hydra.yaml  
					overrides.yaml  
				checkpoints/  
					last.ckpt  
					epoch=004-val_loss=0.231.ckpt  
				logs/
					metrics.json
		2026-06-10_08_24_45/
			...
	plastic/
		...
	mineral_wool/
		...
```

### Config yaml
```yaml
experiment_name: classifier_sweep

hydra:
  run:
    dir: runs/${experiment_name}/${now:%Y-%m-%d_%H-%M-%S}

  sweep:
    dir: runs/${experiment_name}/${now:%Y-%m-%d_%H-%M-%S}
    subdir: ${hydra.job.num}_${hydra.job.override_dirname}

  job:
    chdir: true

  output_subdir: .hydra
  
model:  
	backbone: resnet18
	lr: 0.001
```


# [[Tasks]]

## Agent description

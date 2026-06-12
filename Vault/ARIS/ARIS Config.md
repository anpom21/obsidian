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
experiment_name: wood

model:  
	backbone: resnet18
	lr: 0.001
	...
	
data:
	data_dir: path/to/data
	resolution: 256
	...
	
hydra:
  run:
    dir: runs/${experiment_name}/${now:%Y-%m-%d_%H-%M-%S}

  sweep:
    dir: runs/${experiment_name}/${now:%Y-%m-%d_%H-%M-%S}
    subdir: ${hydra.job.num}_${hydra.job.override_dirname}

  job:
    chdir: true

  output_subdir: .hydra
  
```

### Structured config:
```Python
# config_schema.py
from dataclasses import dataclass, field
from hydra.conf import HydraConf, RunDir, SweepDir, JobConf
from hydra.core.config_store import ConfigStore


@dataclass
class ModelConfig:
    backbone: str = "resnet18"
    lr: float = 0.001


@dataclass
class Config:
    experiment_name}: str = "classifier_sweep"
    model: ModelConfig = field(default_factory=ModelConfig)

    hydra: HydraConf = field(
        default_factory=lambda: HydraConf(
            run=RunDir(
                dir="runs/${experiment_name}/${now:%Y-%m-%d_%H-%M-%S}"
            ),
            sweep=SweepDir(
                dir="runs/${experiment_name}/${now:%Y-%m-%d_%H-%M-%S}",
                subdir="${hydra.job.num}_${hydra.job.override_dirname}",
            ),
            job=JobConf(chdir=True),
            output_subdir=".hydra",
        )
    )


cs = ConfigStore.instance()
cs.store(name="config", node=Config)
```


## Fire store Example
```json
{
	time_stamp: "2026-05-04T10-21-56",
	fileserver_path:"
	model_name: "epoch=004-val_loss=0.231.pt",
	f1: 0.89,
	accuracy: 0.90,
	dataset_file: "2026-05-03T16-53-23",
}
```
# [[Tasks]]
- [ ] Grill session with thesis config and current classification setup
- [ ] Implement data handling in configs
- [ ] Implement new config management
- [ ] Test old method, and new method and ensure similar results are obtained
- [ ] Setup notion table which can be manually written to in the beginning
- [ ] 
## Agent description

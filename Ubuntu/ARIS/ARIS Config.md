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
# [[Tasks]]
- [x] Grill session with thesis config and current classification setup ✅ 2026-06-19
- [x] Implement data handling in configs ✅ 2026-07-08
- [x] Implement new config management ✅ 2026-07-08
- [x] Setup notion table which can be manually written to in the beginning ✅ 2026-07-07
- [x] Change the output structure to also include a tag instead of just a date ✅ 2026-07-08
- [ ] Test old method, and new method and ensure similar results are obtained
- [ ] Rename `default_real_roots` to `default_real_directories`
- [ ] Add a check that validates the input size of the images so they are equal to the desired dimensions. Make them fail fast so the fail wont occur at training time. Display a warning if the im
- [ ] When a model has finished training it should rename the run name of the folder to `trained_<run_folder_name>`  or `evaluated_<run_folder_name` to easily sort through the untrained, trained and evaluated runs. To be renamed to evaluated the run should also be uploaded to the [[Evaluation tracking]]. 
- [ ] Implement efficientnet, objectdetection (YOLO), segmentation model 🔽 
- [ ] Add proper logging 
- [ ] Make the training script print the loaded [[data.yaml]]
- [ ] Migrate from pytorch lightning to regular torch. 🔼 ,
- [x] Instead of saving the models under weird names, just keep them understandable during training. So instead of `model_resnet18_3.0.1_default0.0.1_epoch=02_val_loss=1.14_val_acc=0.72.ckpt` do like `best-val-acc_epoch=02_val_loss=1.14_val_acc=0.72.ckpt` or `lowest-val-loss_epoch=02_val_loss=1.14_val_acc=0.72.ckpt` ✅ 2026-07-20
- [ ] Fix the `_to_namespace` dependency everywhere
- [ ] `mean` and `std` is hard coded into `previeiw_augmentation()` in `train_model.py` fix that, so i takes the mean and std for a config instead maybe.
- [ ] fix data resolver so it can resolve test folder splits and work in `multiruns` ⏫ 
- [ ] Make it possible to pass classes directly in the config like:
```yaml
impregnated_wood:
- impregnated_wood
- impregnated_wood_painted
- outdoor_wood
- outdoor_wood_painted
- forest_wood
- fence_outdoor
- furniture_outdoor

normal_wood:
- normal_wood
- wooden_tool_shaft
- tool_with_wooden_shaft
- pallet
- pallet_collar
- normal_wood_painted
- furniture
- furniture_panel  

floor_tile:
- floor_tile

wood_wool_board:
- wood_wool_board
```
Instead of
```YAML
classes:
impregnated_wood:
real:
subcategories:
- impregnated_wood
- impregnated_wood_painted
- outdoor_wood
- outdoor_wood_painted
- forest_wood
- fence_outdoor
- furniture_outdoor
synthetic:
subcategories:
- impregnated_wood
- impregnated_wood_painted
- outdoor_wood
- outdoor_wood_painted
- forest_wood
- fence_outdoor
- furniture_outdoor
normal_wood:
real:
subcategories:
- normal_wood
- wooden_tool_shaft
- tool_with_wooden_shaft
- pallet
- pallet_collar
- normal_wood_painted
- furniture
- furniture_panel
synthetic:
subcategories:
- normal_wood
- wooden_tool_shaft
- tool_with_wooden_shaft
- pallet
- pallet_collar
- normal_wood_painted
- furniture
- furniture_panel
floor_tile:
real:
subcategories:
- floor_tile
synthetic:
subcategories:
- floor_tile
wood_wool_board:
real:
subcategories:
- wood_wool_board
synthetic:
subcategories:
- wood_wool_board
```
## Ideas
- Use hydra to organize configs
- Use tensorboard to write logging messages
- Use pytorch to write checkpoints 
#### Hydra optimize multiruns
- Evaluate option 
	- `evaluation.evaluate = {report, metrics, false, true} # default: "report", true = "report"`
- Metrics
```yaml
#Changed parameters
multirun_parameters:
	optimizer.learning_rate: 0.1
	augmentation.cutmix.p: 0.3
	system.seed: 2
```

#### Optimization
If a hydra multi run is running, a lot of parameters can sometimes be explored resulting in 100+ runs, in this case it is imperative that time is not wasted too much and that memory for model checkpoints does not become a problem (luckily checkpoint trimming is now implemented). 
Grill me on how early stopping can be expanded to also consider the performance of earlier runs in a multirun. There should be a simple check for if after x epochs the models is not within y points of the primary metric then the training should terminate and move on to the next parameter. Example: if the best model performance on the validation data is not within 15% after 25 epochs of the best model then the training loop should terminate.

Im also open to discuss a more suffisticated method where if after a epochs the model is not projected to improve beyond the best model then just terminate. Where the projection would be calculate from either a linear fit from the last n validation evaluations or a more suited model fit. Idk if other has done this before?  

Add an option to what should happen when a training run is terminated. Eg. nothing, erase the statedict of the checkpoint (do this rather than remove the file as i dont feel safe on using remove functions in python), so the checkpoint is updated to basically take up no space.

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

## Agent description

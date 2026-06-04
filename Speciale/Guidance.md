### Classifier guidance
Dhariwal and Nichol 2021 proposes Classifier guidance which leverages a pretrained **classifier model** to guide the reverse diffusion process of a pretrained unconditional DM on a desired class label.
This method ensures that the generated samples conform to the target class distribution without any need to retrain the unconditionally trained DNN.

### Classifier-Free guidance
Ho and Salimans 2022 proposes Classifier-Free guidance eliminating the need of a classifier model by conditioning the DM on class labels during training.


---
created: 2026-06-09
tags:
  - Speciale
source:
aliases:
---





## Better deep ensemble setup
Yes. The key issue is that the evaluation pipeline has **nested sources of randomness**, not just one source.

Your pipeline is roughly:

> diffusion training → synthetic dataset generation → ResNet training → macro accuracy

So the final accuracy varies because of several things:

1. The diffusion model may train slightly differently each time.
    
2. The generated synthetic dataset may differ.
    
3. The ResNet classifier may train differently each time.
    

A simple t-test is not ideal because it usually assumes the observations are independent samples from one flat population. But in your case, several ResNet results may come from the **same diffusion model**, so they are correlated.

---

## Why the stronger test is better

Suppose you train:

- 30 diffusion models.
    
- For each diffusion model, train 10 ResNets.
    

Then you get accuracy values like:

[  
y_{ij}  
]

where:

- (i) = diffusion model index,
    
- (j) = ResNet training index,
    
- (y_{ij}) = final macro accuracy.
    

Now you can ask:

> How much of the final accuracy variance comes from changing the diffusion model, and how much comes from changing only the ResNet seed?

That is better than asking only:

> Is the mean of group A different from the mean of group B?

Because your methodological question was not only about mean performance. It was about **where uncertainty enters the pipeline**.

---

## What the different tests mean

### 1. Simple t-test

A t-test compares the means of two groups.

Example:

> Is the mean accuracy from a diffusion ensemble different from the mean accuracy from a ResNet ensemble?

This is useful when you have two independent groups and want to know whether their means differ.

But it is weak here because it does not naturally separate:

- diffusion variance,
    
- dataset generation variance,
    
- ResNet training variance.
    

It would tell you whether two mean estimates differ, but not **why** they differ.

---

### 2. ANOVA

ANOVA asks whether different factors explain variation in the result.

Example:

> Does the diffusion seed significantly affect downstream accuracy?

A simple ANOVA could treat each diffusion model as a group and test whether the mean ResNet accuracy differs across diffusion trainings.

That is closer to the real question, because it checks whether different diffusion models produce systematically different downstream results.

But a basic ANOVA is still limited if the structure is nested or unbalanced.

---

### 3. Mixed-effects model

A mixed-effects model is more appropriate for your setup because it models the hierarchy directly.

You could write:

$y_{ij} = \mu + d_i + r_{ij}$  

where:

- ($\mu$) is the overall mean accuracy,
    
- ($d_i$) is the effect of diffusion model (i),
    
- ($r_{ij}$) is the remaining ResNet-level variation.
    

Then the model estimates:

$\sigma^2_{\text{diffusion}}$  

and

$\sigma^2_{\text{ResNet}}$  


This directly answers:

> Does changing the diffusion model contribute more uncertainty than retraining the downstream classifier?

That is why it is stronger.

---

### 4. Variance component estimation

Variance component estimation is the practical outcome of the mixed-effects model.

It tells you something like:

> 60% of the variance comes from diffusion training, 30% from ResNet training, and 10% from residual noise.

That would be much stronger than saying:

> The diffusion ensemble looked closer to the 5×5 mean.

Your Figure 5.4.3 is useful as an exploratory result, but a variance-component analysis would turn that visual observation into a statistically grounded conclusion.

---

## What the stronger experimental design would look like

A stronger version would be:

1. Train 30 diffusion models with different seeds.
    
2. Generate one or more synthetic datasets from each diffusion model.
    
3. Train maybe 5–10 ResNets per generated dataset.
    
4. Record macro accuracy for every combination.
    
5. Fit a mixed-effects model or perform nested ANOVA.
    
6. Estimate how much variance comes from diffusion training versus ResNet training.
    

Then you could say something like:

> “Diffusion-model training accounts for X% of the downstream accuracy variance, while ResNet training accounts for Y%. Therefore, diffusion-level ensembles are the more informative evaluation method.”

That would be a much stronger claim than simply observing that the diffusion ensemble happened to be closer to the 5×5 estimate in one experiment.

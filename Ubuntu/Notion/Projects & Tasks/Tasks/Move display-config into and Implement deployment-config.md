---
base: "[[Tasks.base]]"
Last edited time: 2025-05-16T09:50:00
Current sprint: false
Assignee:
  - 7a9bee9b-5241-436b-9b1d-7f58eff580bf
Status: Done
Due: 2025-05-28
Priority: Medium
Project:
  - "[[Notion/Projects & Tasks/Projects/Admin page for upload of models to units|Admin page for upload of models to units]]"
---
Deployment configs will contain information on the following:

- <u>Mapping</u> of model output
- <u>Thresholds</u> for model output
- <u>Display</u> output that matches the model output and is customised to the customer
- Model name
- Version number
- Class names
- TemperatureScaling

The four pieces of information in the bottom are to be implemented programmatically and to be fetched from the training-config associated with the chosen model-run

The three pieces of information in the top are fetched from the matching dropdown menus on the admin page

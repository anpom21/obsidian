---
notion-id: 1eea52e3-6b64-800b-af88-fe2da9118507
base: "[[Tasks.base]]"
Last edited time: 2025-05-16T09:53:00
Current sprint: false
Assignee:
  - 7a9bee9b-5241-436b-9b1d-7f58eff580bf
Status: Done
Due: 2025-05-28
Project: []
---
- [ ] Remove the group deploy code.
- [x] Talk about how the deployment config should be implemented in wade
- [ ] Refactor wade system code to use the firebase object instead of config files, for deployment related configs.
    - [ ] Refactor the wade system code related to the display  part of the  deployment config
    - [ ] Refactor the wade system code related to the model  part of the  deployment config
    - [ ] Refactor the wade system code related to the classes part of the  deployment config
    - [ ] Refactor the wade system code related to the mapping part of the  deployment config
    - [ ] Refactor the wade system code related to the fractions part of the  deployment config
- [ ] Write a script that uploads the current config of wades, converted into the new format.
    - [ ] Write the code that reads the current config of a wade
    - [x] Decide whether to use a firebase object or a config file (doesn’t have to be the same decision locally and remotely)
        - [ ] Write the code that converts the config into a firebase object, with the new format.
        - [ ] Write the code that uploads the object to firebase
- [ ] Call the function that reads the current config of a wade, converts it to the new format, and uploads it to firebase, for all wades.
- [ ] Use the new deployment config format, which is now stored in the back end, to dynamically read the evaluation categories on insights.
    - [ ] Write the code that starts looking for the evaluation categories in the unit deployment config data, when loading a unit in the unit detail page
    - [ ] Write the code that finds the evaluation categories in the unit deployment config data in the correct place
    - [ ] Write the code that parses the format of the deployment config to extract evaluation categories
    - [ ] Write the code that inserts the evaluation categories found in the deployment config, into the unit detail page.
    - [ ] Update the view from the new evaluation categories loaded from the deployment config.
---
base: "[[Tasks.base]]"
Last edited time: 2026-07-22T13:37:00
Current sprint: true
Assignee: []
Status: Not Started
Project: []
---

Data splitting by day batches: Implement a new data splitter method that groups data in batches of days
Make sure that a the val split has data from an unseen machine to make the model more robust. 

For the test set make sure it has at least one, maybe two machines that the neither the val or the train split has. And make sure that the data is as mentioned grouped in batches of days so if two images of the same object is taken right after each other it wont leak into one of the other splits.

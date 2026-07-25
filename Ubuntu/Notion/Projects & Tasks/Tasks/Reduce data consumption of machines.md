---
base: "[[Tasks.base]]"
Last edited time: 2025-11-10T14:15:00
Current sprint: false
Assignee:
  - 7a9bee9b-5241-436b-9b1d-7f58eff580bf
Status: Done
Due: 2025-10-16
Priority: High
Project:
  - "[[Notion/Projects & Tasks/Projects/General improvements|General improvements]]"
---
- [ ] Reduce data consumption of Wades
    - Playful-monkey located in RoboHouse is prime example of this
    - Use nexcon to view its data consumption
    -  Playful monkey is currently running no state-machine but averaging 60 MB in daily base data consumption and then spiking to well over 1 GB every 3-7 days.  60 MB daily is almost 2 GB monthly which is way to much. 
    - Goal for data consumption is < 5 MB daily data consumption without any systems running.
    - We also know that the big block of data consumption (over 1 GB) comes in the morning between 5 & 6 AM


Remember Playful Monkey has switched OpenVPN profile to the new one (192.168.25.225)


---
base: "[[Tasks.base]]"
Last edited time: 2026-02-13T19:25:00
Current sprint: false
Assignee:
  - 7a9bee9b-5241-436b-9b1d-7f58eff580bf
Status: Done
Due: 2025-06-19
Priority: Medium
Project: []
---
- [ ] Look into what parts of state machine actions concurrency code could be refactored.
- [ ] Make sure the timer refactor has been merged.
- [ ] Decide where we need to use thread pool executor and or asyncio
- [ ] Decide if we still need to use futures.
- [ ] Remove the futures we don’t need and refactor
- [ ] Make sure the code that needs to be synchronous is synchronous
- [ ] Make sure the long synchronous waiting code is behind the loading screen.
- [ ] Make sure that the synchronous code does not break anything else
- [ ] Make sure the code that needs to be asynchronous is ansynchronous
- [ ] Make sure the things depending on asynchronous code, waits and gets executed at the correct time
- [ ] Handle shared memory synchronization between concurrent code parts
- [ ] Make sure there are no concurrent code that crashes because of trying to access the same memory.
- [ ] Make sure there are no deadlocks or other cuncurrency complications
- [ ] Make sure there is no thrashing
- [ ] Clean up threads and processes.
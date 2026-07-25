---
base: "[[Tasks.base]]"
Last edited time: 2026-07-21T13:35:00
Current sprint: false
Assignee:
  - Andreas Pommerencke
Status: Done
Priority: Medium
Project: []
---
Improvements:

1. ✅Brightness slider
    - Look to insights for inspiration
    - (Is there other image manipulation sliders that would make sense?, contrast, hue, saturation?)
2. Implement more directory template structures. Right now it has wood, but it should also include mineral_wool and plastic. Make a setup for making and updating directory template structures
3. ✅Image sorter should read from the inference record of a capture and display the machine eval, and (three?, test what makes sense) of the user evaluations (if available)
4. ✅Image sorter should have a mode, where all images from the capture can be viewed, without having to enter specific categories: The directory category, machine eval and other relevant data should then be displayed next to the image.  

2026-04-04 - Andreas:
Test out the image sorter on the simon pc at: `aris sort <capture dir>` 

Changes are on the `ap/capture_viewer` branch if used on a different machine.

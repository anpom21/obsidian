---
created:
tags:
source:
aliases:
---
- [x] sync to fierce-wolf ⏫ ✅ 2026-06-04
- [x] train new low res model with normal mineral wool as testing data ✅ 2026-06-04
- [x] work on excalidraw ✅ 2026-06-04
- [ ] Make excalidraw overview of config
- [ ] Check out how to make a people dictionary
- [ ] Make excalidraw of classification pipeline and [[classification]] evaluation logging
- [ ] Make [[Obsidian]] new note auto put in date #agent 
  - Answer: Use Templater for the note body/frontmatter and QuickAdd for the filename. For a creation date in every new note, add `created: <% tp.date.now("YYYY-MM-DD") %>` to the relevant template. For notes created through QuickAdd, include `{{DATE:YYYY-MM-DD}}` in the filename or template. Daily Notes already points at `Templates/daily.md`, so that template can carry the date automatically for daily pages.
- [ ] Make `aris sync` print out capture path at the end and optionally copy to clipboard. [[aris sync]] #agent #implement 
- [ ] Think of way to best way/ place to store task when using obsidian shortcut, maybe have shortcut go to daily note instead? 🔽 #agent 
  - Answer: Keep the shortcut as a quick capture into `Tasks.md` or an Inbox capture, then review it into daily/project notes later. Sending every shortcut task directly to the daily note feels tidy today but makes old tasks harder to find after a few days. A good setup is: capture fast to `Tasks.md`, optionally prefix with today's date or source, and use the existing Tasks queries plus daily review to decide what belongs on today's note.
- [ ] Fix [[Zsh]] terminal bugs #home  🔽 
- [ ] [[aris sync]] fix default folders for mineral wool #agent #implement 
- [ ] [[aris sort]] prompt user if the new 'Added folder' should be added to default folders
- [ ] [[aris sort]] "Make a 'Clean up' folder button, that deletes all empty folders, make sure that all subfolders are also empty" #agent #implement 
- [x]  ✅ 2026-06-04
- [ ] [[WADE]] make it possible to configure normalization in deployment config #agent #implement
- [x] [[WADE]] "Make a bash script that first of all checks if state machine is running on systemctl, if it is close script prompting user to close it. If everything is fine, then run the state_machine.py, in one thread perhaps just with `bash path/to/state_machine.py &`, then after 5s, pass one photo at a time to `/tmp/wade/image.png`, run `touch tmp/wade/ipfc/BUTTON.ipfc` to simulate button press,  wait for the `find /home/aris/images_backup -maxdepth 2 -type f -mmin -0.1` to detect a new added image, as this command basically checks  if the image has been imported, run that command every 5s, when it runs succesfully, wait 5s and then switch the next image and simulate the button press again. Continue until all images have been processed." ✅ 2026-06-05
-  Stena recylcing
	-  Aftager affald fra genbrugs station
- [ ] Heyo





# This week
```tasks
# Only tasks that are not done, that is, which begin like this (but without the quotes):
#   '- [ ] ' or
#   '* [ ] ' or
#   '1. [ ] '
# Indented tasks are supported, but only single-line tasks.
not done

# Tasks due today or earlier:
due before next week

# Restrict to at most 100 tasks.
# If you ask Tasks to display many hundreds or thousands of tasks,
# Obsidian's editing performance really slows down.
limit 100

# Group and sort the output:
group by filename
sort by description

# Optionally, ask Tasks to explain how it interpreted this query:
```

# Work tasks
```tasks
not done

# Tags including
tag includes #work

# Restrict to at most 100 tasks.
limit 100

# Group and sort the output:
group by filename
sort by description

```
# Home tasks
```tasks
not done

# Tags including
tag includes #home 

# Restrict to at most 100 tasks.
limit 100

# Group and sort the output:
group by filename
sort by description

```

# Tasks waiting
```tasks
not done

# Tags including
tag includes #waiting 

# Restrict to at most 100 tasks.
limit 100

# Group and sort the output:
group by filename
sort by description

```

# All tasks
```tasks
# Only tasks that are not done, that is, which begin like this (but without the quotes):
#   '- [ ] ' or
#   '* [ ] ' or
#   '1. [ ] '
# Indented tasks are supported, but only single-line tasks.
not done

# Tasks due today or earlier:
# due before tomorrow

# Restrict to at most 100 tasks.
# If you ask Tasks to display many hundreds or thousands of tasks,
# Obsidian's editing performance really slows down.
limit 100

# Group and sort the output:
group by filename
sort by description

# Optionally, ask Tasks to explain how it interpreted this query:
```

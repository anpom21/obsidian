---
base: "[[Tasks.base]]"
Last edited time: 2026-01-06T12:54:00
Current sprint: false
Assignee:
  - e64f86d8-b9dc-4fed-a706-aa429bebcafb
  - 7a9bee9b-5241-436b-9b1d-7f58eff580bf
Status: In Progress
Due: 2025-06-19
Priority: High
Project: []
---
- [x] Research why and when the Jetson would have a reset timestamp
- [x] Design a solution so that the clock is updated before the first picture is taken
- [ ] Implement solution for image grabbing with correct timestamps

### Description

There seems to be a systemd service that sets the time, which our services do not depend upon. If they did, the time would be correct on the images captured. However, the timesync service depends on the internet connection, which means our services would have to wait for a connection before starting the state-machine etc. There are multiple possible solutions:

- Have our services depend on the timesync service.
- Add a battery cell to the Jetson for local RTC backup.
- Create a software fix where (pseudocode follows)

```python
if image_is_from_1970(image_name):
	unsynced_images.append(image_path)
	out_of_sync = True
	timer_since_first_out_of_sync_image_capture = Timer()
	
if out_of_sync and not image_is_from_1970(image_name):
	# system has set correct system clock
	update_images_with_correct_timestamp(unsynced_images)
	
def update_images_with_correct_timestamp():
	actual_times = []
	time_since_epoch_of_first_image_capture = timedelta(unsynced_images[0], time.unix_epoch_0)
	actual_time_of_first_capture = time.now() - timer_since_first_out_of_sync_image_capture
	
	actual_times.append(actual_time_of_first_capture)
	
	for unsynced_image in unsynced_images[1:]:
		actual_time = time.now() - timer_since_first_out_of_sync_image_capture + timedelta(unsynced_image, unsynced_image[0])
		actual_times.append(actual_time)
	
	overwrite_filepaths_of_unsynced_images(unsynced_images, actual_times)
```

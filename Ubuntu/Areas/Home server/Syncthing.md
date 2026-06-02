First install [syncthing](https://syncthing.net/downloads/) on all your desired devices.


# Ubuntu
## Start on boot
Enable Syncthing for your user
```bash
systemctl --user enable syncthing.service
systemctl --user start syncthing.service
```
Verify it is running
```bash
systemctl --user status syncthing.service
```
Allow it to run even when not logged in
```
loginctl enable-linger $USER
```
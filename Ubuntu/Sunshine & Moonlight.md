
## Frozen full screen

Harsh, but works:
```
loginctl terminate-user <user>
```

## Can't connect due to dead graphics session

### Fix teamviewer
Diagnose
```
loginctl list-sessions
```
This is might not be desirable:
```
ap@desktop:~$ loginctl list-sessions
SESSION  UID USER SEAT  TTY  STATE  IDLE SINCE
    523 1000 ap   seat0 tty2 active yes  12h ago
    633 1000 ap   -     -    active no   -
```
This might be preffered
```
ap@desktop:~$ loginctl list-sessions
SESSION  UID USER SEAT  TTY  STATE  IDLE SINCE
    633 1000 ap   -     -    active no   -
    635 1000 ap   seat0 tty2 active no   -

2 sessions listed.
```
Fix it:
```
sudo systemctl restart teamviewerd
sudo systemctl restart gdm3
```

That should fix teamviewer.
Then log into teamviewer and start sunhine:
```
sunshine &
```

# Future fix you can try:
## Optional but recommended (stability)

### Disable Wayland (Sunshine + NVIDIA is still fragile)

You already restarted GDM, so do this once:

`sudo nano /etc/gdm3/custom.conf`

Ensure:

`WaylandEnable=false`
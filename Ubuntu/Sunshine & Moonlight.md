## FPS Limiter
### Ubuntu
1. Clone fps strangle ([link](https://github.com/milaq/libstrangle))
```
git clone https://github.com/milaq/libstrangle
cd libstrangle
```

2. Install the build package `libc6-dev-i386`
```
sudo apt install libc6-dev-i386
```
3. Make and install
```
make
sudo make install
```
4. Set fps limit
For every game you need to do this step.
Go to steam right-click on a game in your **library** and selecting **Properties** , then go to **General** then set **launch** **options** to: `strangle <your desired fps limit> %command%`

5. When you are done you should have something like this:
![[Pasted image 20251212190407.png]]

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

## Moonlight graphics error
### Port already in use
If you got the following message when running `sunshine`
```
Fatal: Couldn't bind RTSP server to port [48010], Address already in use
```
Check what is using that port:
```
sudo ss -ltnp | grep :48010
```
Then fix it by killing the instance listening to that port (likely sunshine).
```
pkill -x sunshine || true
sudo fuser -k 48010/tcp || true
```
Start sunshine again
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


## Sunshine start 

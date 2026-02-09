- [SSH](SSH.md)
- 

___
# Keychron K10 v2 Bluetooth issues

See issue [here](https://gist.github.com/andrebrait/961cefe730f4a2c41f57911e6195e444#enable-bluetooth-fast-connect-config)
1. Edit the file `/etc/bluetooth/main.conf`
2. Uncomment FastConnectable config and set it to true: `FastConnectable = true`
3. Uncomment `ReconnectAttempts=7` (set the value to whatever number that you want)
4. Uncomment `ReconnectIntervals=1, 2, 3`
5. Run: `sudo systemctl restart bluetooth`
___
# Add AppImage as ubuntu app
### 1) Move the AppImage to an Applications folder 
Can be anywhere you choose.
```bash
mkdir -p ~/Applications
mv ~/Downloads/<APP>.AppImage ~/Applications/<APP>.AppImage
chmod +x ~/Applications/<APP>.AppImage
```
### 2) Create a `.desktop` launcher
Create the file:
```bash
nano ~/.local/share/applications/moonlight.desktop
```
Paste a `Desktop Entry`
```ini
[Desktop Entry]
Type=Application
Name=<Name>
Comment=<comment>
Exec=/home/ap/Applications/<APP>.AppImage
Icon=<icon name without .png>
Terminal=false 
Categories=<cat2>;<cat2>;
StartupWMClass=<Name>
```
Example with moonlight:
```ini
[Desktop Entry]
Type=Application
Name=Moonlight
Comment=Game streaming client
Exec=/home/ap/Applications/Moonlight.AppImage
Icon=moonlight
Terminal=false
Categories=Game;Network;
StartupWMClass=Moonlight
```
Save and exit
### 3) (Optional) Set a proper icon
Find a prober `.png` logo, either from the internet or in the AppImage as demonstrated below:
```bash
cd ~/Applications
./<APP>.AppImage --appimage-extract
```
Find the icon:
```bash
find squashfs-root -iname "*<APP>*png" -o -iname "*<APP>*svg"
```
Copy one to icons:
```bash
mkdir -p ~/.local/share/icons
cp squashfs-root/usr/share/SOME/PATH/<APP>.png ~/.local/share/icons/
```
(Size adjustment might be required 256x256)

### 4) Refresh the desktop database
```bash
update-desktop-database ~/.local/share/applications
```
Verify by searching for the app.
Or launch with:
```bash
gtk-launch <app name>
```

___
# Hard reset audio settings
### 0. Close everything using audio

- Quit Discord
- Quit browser tabs with audio
- Quit pavucontrol
### 1. Kill the entire user audio stack

```Bash
systemctl --user stop pipewire pipewire-pulse wireplumber
```
Verify nothing is running:
```bash
ps aux | grep -E "pipewire|pulse" | grep -v grep
```
Should return **nothing**.
### 2. HARD reset user audio config (this is the key step)

This deletes all **user-level ALSA / Pulse / PipeWire state**.

```
rm -rf ~/.config/pulse 
rm -rf ~/.config/pipewire 
rm -rf ~/.config/wireplumber 
rm -rf ~/.local/state/pipewire 
rm -rf ~/.local/state/wireplumber 
rm -rf ~/.cache/pulse
```
Do **not** skip any of these.
### 3. Reset ALSA completely

```bash
sudo alsa force-reload
```
If that command is missing:

```bash
sudo systemctl restart alsa-restore
```

Optional but recommended:

```bash
sudo rm -rf /var/lib/alsa/asound.state
```
### 4. Reboot

Do **not** skip reboot.

```bash
reboot
```
### 5. Verify clean state (before opening Discord)

After reboot, run:

```bash
pactl list short sources
```
___
## Turn .png's into a .gif using FFMPEG
The basic command to turn images into a gif.
```bash
ffmpeg -i %04d_color.png output.gif
```
Where `%04d_color.png` expects images to appear as `0001_color.png`, `0002_color.png` and so on.
If the images just counts up, use:
```
ffmpeg -i image-%d.png output.gif
```

### Increase time between frames

```
ffmpeg -framerate 30 -i %04d_composite.png   -vf "setpts=2*PTS,scale=900:-1:flags=lanczos"   output9.gif
```

### Keep transparency
```
ffmpeg -framerate 30 -i %04d_composite.png   -vf "setpts=4*PTS,scale=1000:-1:flags=lanczos,split[s0][s1];[s0]palettegen=reserve_transparent=1:transparency_color=ffffff[p];[s1][p]paletteuse=dither=bayer:bayer_scale=3:alpha_threshold=128"   -loop 0 output4.gif
```
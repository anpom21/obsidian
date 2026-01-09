- [SSH](SSH.md)
- 


## Keychron K10 v2 Bluetooth issues

See issue [here](https://gist.github.com/andrebrait/961cefe730f4a2c41f57911e6195e444#enable-bluetooth-fast-connect-config)
1. Edit the file `/etc/bluetooth/main.conf`
2. Uncomment FastConnectable config and set it to true: `FastConnectable = true`
3. Uncomment `ReconnectAttempts=7` (set the value to whatever number that you want)
4. Uncomment `ReconnectIntervals=1, 2, 3`
5. Run: `sudo systemctl restart bluetooth`

## Add AppImage as ubuntu app
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
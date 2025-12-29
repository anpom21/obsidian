For common errors checkout [Stack over flow](Stack%20over%20flow.md)

This YouTube [video](https://www.youtube.com/watch?v=IuRWqzfX1ik&) covers the basics quite well.
- Acquire a computer could be any of
	- Raspberry Pi
	- Old laptop
	- Dedicated server
	- Desktop PC
## Install the server OS
There are plenty of OS available depending on what kind of server you want, so first you should pick your server OS.
### Choose one of the following server operating systems
- Ubuntu 24 server
	- Simple and stable
	- https://ubuntu.com/download/server
- OpenMediaVault (OMV)
	- Good for managing storage (NAS)
	- 982MB
	- https://www.openmediavault.org/download.html
-  ZimaOS
	- Nice intuitive GUI (can be build on top of OMV)
	- https://www.zimaspace.com/docs/zimaos/how-to-install-zimaos

## Flash the image
The image is probably around 4 GB,  so pick a USB drive that fits that.

Use [balena etcher](https://etcher.balena.io/) or similar to flash the image to the USB.


### Upload SSH keys to github
Optional but **recommended**. By uploading the ssh keys to [GitHub](https://github.com/settings/keys) it is super easy for the OS to find the keys, which they can do simply with your github username. 
If you just want to type them in later you can navigate to your `.ssh/` folder (typically at `~/.ssh/`) and then simply print the public key (typically its name `id_ed25519.pub`):
```bash
cat ~/.ssh/id_ed25519.pub 
```


Other than that the install should be pretty simple. 
- Plug the USB in when the PC is powered off
- Choose `try or install ubuntu`
	- If grub menu does not show up you can force the grup menu through bios



## Wake on LAN
Enable Wake on LAN in bios if available. If it is not shown in bios, then it can probably only be waken from suspend.

**Enable wake on suspend in ubuntu**
- Identify ethernet id
	- `ip a`
		- Look for a entry with `enp` in the name eg.:
			- `5: enp5s0: <BROADCAST,MULTICAST,UP,LOWER_UP>` LOWER UP means it is connected
- Check the wake status
	- `sudo ethtool enp5s0`
		- Eg. 
 ```
Supports Wake-on: pumbg
Wake-on: d
Link detected: yes
```
If it cant detect a link try forcing a reload
```
sudo ip link set enp5s0 down
sudo rmmod r8169
sudo modprobe r8169
sudo ip link set enp5s0 up
```
- Enable Wake on suspend with:
		- `sudo ethtool -s enp5s0 wol g`
- Next the wake on suspend should be enabled permanently 
	- First create this file:
		- `etc/systemd/network/10-wol.link`
	- Determine the MAC Address of the ethernet connection, it is visible from `ip a`
		- Eg. `link/ether c8:60:00:02:a5:61`
	- Insert theses lines of code
```
[Match]
MACAddress=<ethernet MAC Address>

[Link]
WakeOnLan=magic
```
It will enable the ethernet connection to wake the pc through LAN.
- Finally the settings should be applied. Run:
	- `sudo udevadm control --reload`
	- `sudo udevadm trigger -c add`
Now it can be tested.
- Suspend the server
	- `sudo systemctl suspend`
- From another machine wake the server (requires `wakeonlan` package)
	- `wakeonlan c8:60:00:02:a5:61`
## Setting up VPN
Tailscale is free to use "vpn" that allows you to ssh between devices on the same tailscale network. And its free! [Check it out!](https://tailscale.com/)


## Disable lid switch 
If using a laptop as a homeserver then it will beneficial to close the laptop, but still have it running.
- **Disable LID Switch in bios**
	- If bios has a lid switch option disable it.
- Disable lid switch in ubuntu
```
sudo nano /etc/systemd/logind.conf
```
- Change the following lines:
```
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
LidSwitchIgnoreInhibited=no
```
These lines may be commented out make sure to remove the comment `#`
(It might be only one of these needs to be disabled but i just disabled them all to be sure)

- Apply changes
```
sudo systemctl restart systemd-logind
```
### Port forwarding

## Pi-Hole
Internet wide ad blocker.
#### DNS Port 53
Ensure port 53 is not taken.
```
sudo lsof -i -P -n | grep LISTEN
``` 
If anything else listens, it is very likely its `systemd-resolved`
To solve that you need to edit the `/etc/systemd/resolved.conf` and uncomment `DNSStubListener` and change it to `no`, so it looks like this: `DNSStubListener=no`

After that reboot your system or restart the service with `service systemd-resolved restart`
#### Port 80 is occupied
It might occur that port 80 is occupied by CasaOS. There fore the port should be changed, change the line `port = "80o,443os,[::]:80o,[::]:443os"` in `/etc/pihole/pihole.toml`:
```
sudo nano /etc/pihole/pihole.toml
```
Use `Ctrl + W` (in nano) to search for 80 to make the search quicker.
Finally change the line to:
```
port = "8080o,443os,[::]:8080o,[::]:443os"
```
##### Black lists:
Spotify
`https://gist.githubusercontent.com/opus-x/3e673a9d5db2a214df05929a4eee6a57/raw`


## Plex
Download plex from the app store. If you have issues assigning the media folder, try to go to this link `http://<your-server-ip>:32400/web`.
From there you should be able to configure your media folder


## Firewall
Install `ufw` as it is the most common firewall.
```
sudo apt install ufw
```
You can manually setup allowed ports like so `sudo ufw allow <port>/<tcp|udp>` here are some examples and recommended ports if you have installed everything thus far:
```
sudo ufw allow 22/tcp \ # ssh
&& sudo ufw allow 7878/tcp \
&& sudo ufw allow 8989/tcp \
&& sudo ufw allow 9091/tcp \
&& sudo ufw allow 32400/tcp \ # Plex
&& sudo ufw allow 32400/udp \ # Plex
&& sudo ufw allow 81/tcp \    # CasaOS
&& sudo ufw allow 8080/tcp \  # Pi-Hole
&& sudo ufw allow 8123/tcp \  # Home assistant
&& sudo ufw enable
```
## CasaOS
Install with one command
`curl -fsSL https://get.casaos.io | sudo bash`

### Minecraft server
The minecraft server is setup with docker. See the documentation [here](https://github.com/itzg/docker-minecraft-server?tab=readme-ov-file).
Great youtube [tutorial](https://www.youtube.com/watch?v=CpmsLOX-7DE).
More notes here [Minecraft](Minecraft)
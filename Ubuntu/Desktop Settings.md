

# Windows
## Shared samba folder
1. Go to `Control Panel > Programs and Features > Turn Windows features on or off`
2. Check the box for "**SMB 1.0/CIFS File Sharing Support**"
3. Restart
Run this from administrator PowerShell.
```
Set-SmbClientConfiguration -RequireSecuritySignature $false  
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" RequireSecureNegotiate -Value 0 -Force
```

# Ubuntu
## Force boot into windows from ubuntu
1. Run
```
sudo efibootmgr
```
You should see something like:
```
BootCurrent: 0002
Timeout: 1 seconds
BootOrder: 0002,0000,0003,0004,0005
Boot0000* Windows Boot Manager (...)
Boot0002* Ubuntu	(...)
```
2. Boot into windows on the next boot
```
sudo efibootmgr -n 0000
```
2. Reboot
```
sudo reboot
```

## Auto mount server folder
1. Install CIFS tools
```
sudo apt install cifs-utils
```
2. Create credentials file
```
sudo nano /etc/samba/creds.myshare
```
Add (dont change `domain`):
```
username=YOURUSER
password=YOURPASS
domain=WORKGROUP 
```
Secure it:
```
sudo chmod 600 /etc/samba/creds.myshare
```
3. Add entry to `/etc/fstab`
Change **ip** and **shared_folder**
```
# mount samba share
//<ip>/<shared_folder>  /mnt/share  cifs  credentials=/etc/samba/creds.myshare,iocharset=utf8,uid=1000,gid=1000,file_mode=0775,dir_mode=0775,_netdev,x-systemd.automount  0  0
```
Example:
```
//server.gazelle-shilling.ts.net/Share  /mnt/share  cifs  credentials=/etc/samba/creds.myshare,iocharset=utf8,uid=1000,gid=1000,file_mode=0775,dir_mode=0775,_netdev,x-systemd.automount  0  0
```
4. Create a mount point
Here you can change the folder name **myshare**
```
sudo mkdir -p /mnt/myshare
```
Test wihout reboot:
```
sudo systemctl daemon-reload
sudo mount -a
ls /mnt/myshare
```


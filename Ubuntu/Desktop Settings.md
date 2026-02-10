

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

## SD Card formatter
[link](https://www.sdcard.org/downloads/formatter/sd-memory-card-formatter-for-windows-download/)



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
## Startup windows without password
**Sign into local account** 
1. **Open Settings:** Press **Windows key + I**.
2. **Navigate:** Go to **Accounts** > **Your info**.
3. **Initiate Switch:** Click on **"Sign in with a local account instead"**.
4. **Verify:** Enter your current Microsoft account password or PIN when prompted.
5. **Create Local Profile:** Follow the on-screen prompts to set a new username, password, and password hint for your local account.
6. **Sign Out:** Sign out of your Microsoft account and sign back in with your new local credentials.

**Sign in with auto logon**
1. Download [autologon](https://learn.microsoft.com/en-us/sysinternals/downloads/autologon).
2. Open `autologon.exe` or `autologon64.exe` if available
3. Type in credentials
4. Apply changes

**Disable Fast Startup**
As admin CMD turn off Fast Startup with:
`powercfg /h off`
This also disables hibernation (recommended for dual-boot).
___
## Mount server folder

On the **machine hosting the folder**:
```
sudo apt install samba
```
Create or choose a directory:
```
mkdir -p /srv/shared sudo chown -R $USER:$USER /srv/shared chmod 755 /srv/shared
```
Edit config:
```
sudo nano /etc/samba/smb.conf
```
Append:
```
[shared]    path = /srv/shared    browseable = yes    read only = no    guest ok = no
```
Add Samba user (must exist as Linux user):
```
sudo smbpasswd -a $USER
```
Restart:
```
sudo systemctl restart smbd
```
## Auto mount server folder

### Install CIFS tools
```
sudo apt install cifs-utils
```
### Create credentials file
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
### Add entry to `/etc/fstab`
Change config
```
nano /etc/fstab
```
Change **ip** and **shared_folder**
```
# mount samba share
//<ip>/<shared_folder>  /mnt/share  cifs  credentials=/etc/samba/creds.myshare,iocharset=utf8,uid=1000,gid=1000,file_mode=0775,dir_mode=0775,_netdev,x-systemd.automount  0  0
```
Example:
```
# Server cloud
//192.168.0.188/server_cloud /mnt/server_cloud/  cifs  credentials=/etc/samba/creds.myshare,iocharset=utf8,uid=1000,gid=1000,file_mode=0775,dir_mode=0775,_netdev,x-systemd.a>
```
### Create a mount point
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


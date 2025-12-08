
## Shared samba folder
1. Go to `Control Panel > Programs and Features > Turn Windows features on or off`
2. Check the box for "**SMB 1.0/CIFS File Sharing Support**"
3. Restart
Run this from administrator PowerShell.
```
Set-SmbClientConfiguration -RequireSecuritySignature $false  
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" RequireSecureNegotiate -Value 0 -Force
```

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

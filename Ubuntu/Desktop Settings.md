
## Shared samba folder
1. Go to `Control Panel > Programs and Features > Turn Windows features on or off`
2. Check the box for "**SMB 1.0/CIFS File Sharing Support**"
3. Restart
Run this from administrator PowerShell.
```
Set-SmbClientConfiguration -RequireSecuritySignature $false  
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" RequireSecureNegotiate -Value 0 -Force
```

## Force boot into ubuntu
1. List UEFI entries in PowerShell
```
bcdedit /enum firmware
```
Note the identifier for Ubuntu (looks like `{12345678-ABCD-EF...}`)
2. Set Ubuntu as the next boot 
```
bcdedit /set "{fwbootmgr}" bootsequence "{UBUNTU_GUID}"
```
3. Reboot
```
shutdown /r /t 0
```


## Frozen full screen

Harsh, but works:
```
loginctl terminate-user <user>
```

## Can't connect due to dead graphics session

### Fix teamviewer
Diagnose

```
sudo systemctl restart teamviewerd
sudo systemctl restart gdm3
```
## Install streamdeck-ui

[Github](https://github.com/timothycrosley/streamdeck-ui)
[Installation](https://github.com/timothycrosley/streamdeck-ui/blob/master/docs/installation/ubuntu.md)
## Enable startup service
### Create the service
```bash
mkdir -p ~/.local/share/systemd/user

nano ~/.local/share/systemd/user/streamdeck.service
```

Paste:
```
[Unit]
Description=Stream Deck UI background service

[Service]
Type=simple
ExecStart=%h/.local/bin/streamdeck -n
Restart=on-failure

[Install]
WantedBy=default.target
```
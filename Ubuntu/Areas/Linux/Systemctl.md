## See log
Use journalctl
Example:
```
journalctl --user -u sunshine.service -n 200 --no-pager
```
## Config

Example:
```
systemctl --user cat sunshine.service
```
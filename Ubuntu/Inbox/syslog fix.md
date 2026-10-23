---
created: 2026-06-09
tags:
source:
aliases:
---
```
sudo tail -n 1000 /var/log/syslog > ~/syslog-tail.txt
sudo truncate -s 0 /var/log/syslog
```

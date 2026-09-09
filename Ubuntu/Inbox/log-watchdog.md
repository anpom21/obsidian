---
created: 2026-06-09
tags:
source: https://github.com/ARIS-Robotics/log-watchdog
aliases:
---

## Install
Run
```bash
cd ~/ && git clone git@github.com:ARIS-Robotics/log-watchdog.git
sudo apt update && sudo apt install python3-pip && sudo apt install python3.10-venv
mkdir ~/.env && cp ~/wade-system/data/.env/serviceAccountCredentials.json ~/.env
cd log-watchdog  && bash install.sh
sudo systemctl enable --now log-watchdog@state-machine.service
```
Change service
```
sudo nano /etc/systemd/system/wade-system-dangerous-waste.service
```
Test
```
nano ../wade-system-dangerous-waste/data/.env/wade-system-openai-key.txt
```
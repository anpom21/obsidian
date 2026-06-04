Reenable wifi mask after `sudo systemctl mask wpa_supplicant.service`
```bash
sudo systemctl unmask wpa_supplicant.service
sudo systemctl enable wpa_supplicant.service
sudo systemctl start wpa_supplicant.service
```
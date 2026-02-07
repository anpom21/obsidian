1) Install rclone
```console
sudo -v ; curl https://rclone.org/install.sh | sudo bash
```
2) Run the config
```
rclone config
```
3) Choose SFTP / SSH
4) Make sure the config matches these entries:
```
host = server.gazelle-shilling.ts.net 
user = root 
pass = *** ENCRYPTED *** 
remote_path = /DATA/Documents/synced 
key_file = ~/.ssh/id_ed25519 
pubkey_file = ~/.ssh/id_ed25519.pub
```
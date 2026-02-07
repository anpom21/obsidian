1) Install rclone
```console
sudo -v ; curl https://rclone.org/install.sh | sudo bash
```
2) Run the config
```
rclone config
```
3) Set the name to be `cloud`
4) Choose SFTP / SSH
5) Make sure the config matches these entries:
```
host = server.gazelle-shilling.ts.net 
user = root 
pass = *** ENCRYPTED *** 
remote_path = /DATA/Documents/synced 
key_file = ~/.ssh/id_ed25519 
pubkey_file = ~/.ssh/id_ed25519.pub
```
6) Set the remote path
```
rclone config update cloud remote_path /DATA/Documents/synced
```
7) Verify config
```
rclone config show synced
```
8) Test connection
9) If it fails try:

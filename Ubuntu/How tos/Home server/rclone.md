1) Install rclone
```bash
sudo -v ; curl https://rclone.org/install.sh | sudo bash
```
2) Run the config
```bash
rclone config
```
3) Set the name to be `cloud`
4) Choose SFTP / SSH
5) Make sure the config matches these entries:
```bash
host = server.gazelle-shilling.ts.net 
user = root 
pass = *** ENCRYPTED *** 
remote_path = /DATA/Documents/synced 
key_file = ~/.ssh/id_ed25519 
pubkey_file = ~/.ssh/id_ed25519.pub
```
6) Set the remote path
```bash
rclone config update cloud remote_path /DATA/Documents/synced
```
7) Verify config
```bash
rclone config show synced
```
8) Test connection
9) If it fails try:
```bash
rclone config update cloud key_file ""
rclone config update cloud pubkey_file ""
rclone config update cloud key_file_pass ""
rclone config update cloud pass ""
```
10) Create a rclone alias:
```bash
rclone config create cloud_storage alias remote "cloud:/DATA/Documents/synced"
```
11) Test the alias
```bash
rclone lsf synced_storage:
```

12) Add excludes
```bash
nano ~/.config/rclone/excludes.txt
```

13) Add alias to `.bashrc`
```bash
# ---------------------------------- RCLONE ---------------------------------- #
alias rpush='rclone copy ~/cloud cloud_storage: \
--exclude-from ~/.config/rclone/excludes.txt \
-P \
--update'

alias rpull='rclone copy cloud_storage: ~/cloud \
--exclude-from ~/.config/rclone/excludes.txt \
-P \
--update'

alias rpush-dry='rclone copy ~/cloud cloud_storage: \
--exclude-from ~/.config/rclone/excludes.txt \
--dry-run -P \
--update'
```

## Remove tunneling (eg. password authentication):
	- edit `sudo nano /etc/ssh/sshd_config`
	- `PubkeyAuthentication yes`
	- `PasswordAuthentication no`
## Add github ssh keys to authorized_keys
```
sudo apt install openssh-server
cd ~/.ssh
wget -O ap_keys https://github.com/anpom21.keys
echo "$(cat ap_keys)" >> authorized_keys
```
## Generate ssh key
```
ssh-keygen -t ed25519 -C "your_comment"
```

![[Pasted image 20260207103638.png]]
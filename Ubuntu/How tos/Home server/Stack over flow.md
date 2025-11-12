
### Getting locked out of linux
#### See usernames (if you can reach GRUB or single-user mode)

- Boot the machine.
- At the GRUB menu, highlight your OMV/Linux entry and press **`e`**.
- Locate the `linux`

- At the end of the line add:
	- `init=/bin/bash`
- **Ctrl + X** to boot
- Remount root writable:
	- `mount -o rmount,rw /`
- List user accounts:
	- `cut -d: -f1 /etc/passwd`

### Hold off updates
If docker has a conflicting update with CasaOS, first fix it by [downgrading](https://github.com/IceWhaleTech/CasaOS/issues/2387#issuecomment-3514996581)
1. Update the package list:
```
sudo apt update
```
1. List available docker-ce versions:

```
apt-cache policy docker-ce
```

You will see a list of versions. Copy the exact version string (e.g., 5:25.0.5-1~~debian.12~~bookworm) of the version you want to downgrade to.  
Example snippet string:  
5:28.3.2~~debian.12~~bookworm /last known running
3. Stop Docker Service
```
sudo systemctl stop docker
```
4. Remove Current Docker Packages  
    Remove the existing Docker packages using apt remove. This step removes the binaries, but critically, it leaves your configuration files, images, and containers (stored in /var/lib/docker) intact.
```
sudo apt remove -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
**Warning:** Do NOT use sudo apt purge or manually run sudo rm -rf /var/lib/docker, as this will delete all your containers and images.

5. Install the Specific Older Version
```
sudo apt install -y docker-ce=[VERSION_STRING] docker-ce-cli=[VERSION_STRING] containerd.io
```
Where I used to make it run again :
```
sudo apt install -y docker-ce=5:28.3.2~debian.12~bookworm docker-ce-cli=5:28.3.2~debian.12~bookworm containerd.io
```
6. Start the Docker service
```
sudo systemctl start docker
```
6. Verify the new version and check your containers
```
docker version 
docker ps -a
```
8.Prevent Future Upgrades (Optional)

To HOLD the upgrade of Docker until CasaOS is updated:

```
sudo apt-mark hold docker-ce docker-ce-cli containerd.io
```
To UNHOLD the upgrade of Docker until CasaOS is updated:
```
sudo apt-mark unhold docker-ce docker-ce-cli containerd.io
```
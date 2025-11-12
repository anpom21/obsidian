
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

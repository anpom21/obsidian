
## Bash script installing the basics 

```
# ----- Simple headless installs ----- #
# Apt installs
sudo apt-get install -y build-essential \ # Python
python3-dev \# Python
git \
python3-tk \ # Tk kinter
aptitude \

# SSH
sudo apt install openssh-server
cd ~/.ssh
wget -O ap_keys https://github.com/anpom21.keys
echo "$(cat ap_keys)" >> authorized_keys


# ----- GUI required installs ----- #
# Download and install git credential manager
curl -L "$(curl -s https://api.github.com/repos/git-ecosystem/git-credential-manager/releases/latest \
  | grep browser_download_url \
  | grep linux_amd64 \
  | grep '.deb"' \
  | cut -d '"' -f 4)" \
  -o /tmp/gcm-latest.deb \
  
# Install git credential manager
sudo dpkg -i /tmp/gcm-latest.deb 

# Configure git credential manager
git config --global credential.credentialStore secretservice
git-credential-manager configure
git credential-manager github login
git config --global user.name "Andreas Pommerencke"
git config --global user.email anpom21@student.sdu.dk



# Tailscale
curl -fsSL https://tailscale.com/install.sh | sh
```


# apt packages


### `btop`
PC Performance manager
![[Pasted image 20251230213056.png]]
### `ranger`
File navigation
![[Pasted image 20251230213400.png]]
### `axel`
Download accelerator
```
axel -n <links> rul
```
### `neofetch`
PC summarizer
```
ap@desktop:~/Downloads$ neofetch
            .-/+oossssoo+/-.               ap@desktop 
        `:+ssssssssssssssssss+:`           ---------- 
      -+ssssssssssssssssssyyssss+-         OS: Ubuntu 24.04.3 LTS x86_64 
    .ossssssssssssssssssdMMMNysssso.       Kernel: 6.14.0-37-generic 
   /ssssssssssshdmmNNmmyNMMMMhssssss/      Uptime: 1 hour, 30 mins 
  +ssssssssshmydMMMMMMMNddddyssssssss+     Packages: 2350 (dpkg), 7 (flatpak),  
 /sssssssshNMMMyhhyyyyhmNMMMNhssssssss/    Shell: bash 5.2.21 
.ssssssssdMMMNhsssssssssshNMMMdssssssss.   Resolution: 1920x1080 
+sssshhhyNMMNyssssssssssssyNMMMysssssss+   DE: GNOME 46.0 
ossyNMMMNyMMhsssssssssssssshmmmhssssssso   WM: Mutter 
ossyNMMMNyMMhsssssssssssssshmmmhssssssso   WM Theme: Adwaita 
+sssshhhyNMMNyssssssssssssyNMMMysssssss+   Theme: Yaru [GTK2/3] 
.ssssssssdMMMNhsssssssssshNMMMdssssssss.   Icons: Yaru [GTK2/3] 
 /sssssssshNMMMyhhyyyyhdNMMMNhssssssss/    Terminal: gnome-terminal 
  +sssssssssdmydMMMMMMMMddddyssssssss+     CPU: AMD Ryzen 7 9800X3D (16) @ 5.27 
   /ssssssssssshdmNNNNmyNMMMMhssssss/      GPU: AMD ATI 0d:00.0 Device 13c0 
    .ossssssssssssssssssdMMMNysssso.       GPU: NVIDIA 01:00.0 NVIDIA Corporati 
      -+sssssssssssssssssyyyssss+-         Memory: 9495MiB / 31239MiB 
        `:+ssssssssssssssssss+:`
            .-/+oossssoo+/-.                                       
                                                                   



```

### `ffmpeg`
Video converter.

### `tldr`
Bette help messages.
![[Pasted image 20251230215323.png]]

### `xclip`
Save to clipboard

### `bat`
The internet says to make it work on ubuntu this way:
```
  mkdir -p ~/.local/bin
  ln -s /usr/bin/batcat ~/.local/bin/bat
```
I got i working by:
```
sudo ln -s /usr/bin/batcat /usr/sbin/bat
```
# Snap
### `dust`
![[Pasted image 20260210213251.png]]

### chezmoi
```
snap install chezmoi --classic
```

# .deb packages

### `speedtest`
Download
https://packagecloud.io/ookla/speedtest-cli
```
ap@desktop:~/Downloads$ speedtest

   Speedtest by Ookla

      Server: Fastspeed - Copenhagen (id: 67519)
         ISP: TDC NET
Idle Latency:     5.12 ms   (jitter: 10.25ms, low: 3.83ms, high: 24.34ms)
    Download:   900.43 Mbps (data used: 439.8 MB)                                                   
                 10.44 ms   (jitter: 1.69ms, low: 3.83ms, high: 15.48ms)
      Upload:   927.30 Mbps (data used: 942.9 MB)                                                   
                  5.43 ms   (jitter: 0.67ms, low: 4.12ms, high: 11.17ms)
 Packet Loss: Not available.
  Result URL: https://www.speedtest.net/result/c/ccd683d2-7ff3-4d25-b96e-806e678d4f75
```


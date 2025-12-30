
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


## Apt packages


- `btop`
PC Performance manager
![[Pasted image 20251230213056.png]]
- `ranger`
File navigation
![[Pasted image 20251230213400.png]]

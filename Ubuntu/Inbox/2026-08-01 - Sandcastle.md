---
created: 2026-06-09
tags:
source: https://github.com/mattpocock/sandcastle
aliases:
---
# Install

1. Install npm:
```

```


## Chat:
## 1. Install basic dependencies

```
sudo apt update
sudo apt install -y \
    curl \
    git \
    ca-certificates
```

Do not rely on Ubuntu’s default Node.js package. Sandcastle currently requires a newer Node version than Ubuntu may provide.

## 2. Install Node.js 22 with NVM

The following assumes the shell is Zsh.

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

Load NVM into the current Zsh session:

```
source ~/.zshrc
```

If `nvm` is still unavailable, load it directly:

```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
```

Install Node.js 22:

```
nvm install 22
nvm use 22
nvm alias default 22
```

Verify:

```
node --version
npm --version
```

Expected:

```
v22.x.x
```

Do not run this from Zsh:

```
source ~/.bashrc
```

`~/.bashrc` contains Bash-specific commands such as `shopt`, which produce errors in Zsh.

## 3. Install Docker Engine

For a clean installation, use Docker’s official Ubuntu repository. This installs Docker Engine together with Buildx and the Compose plugin.

Add Docker’s repository:

```
sudo apt update
sudo apt install -y ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL \
    https://download.docker.com/linux/ubuntu/gpg \
    -o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
```

Install Docker:

```
sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin
```

The `docker-buildx-plugin` avoids the legacy-builder warning seen during the first setup.

Start Docker:

```
sudo systemctl enable --now docker
```

Verify the service:

```
sudo systemctl status docker
```
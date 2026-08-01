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

```bash 
sudo apt update
sudo apt install -y ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL \
    https://download.docker.com/linux/ubuntu/gpg \
    -o /etc/apt/keyrings/docker.asc
# 
# sudo chmod a+r /etc/apt/keyrings/docker.asc
# 
# sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null <<EOF
# Types: deb
# URIs: https://download.docker.com/linux/ubuntu
# Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
# Components: stable
# Architectures: $(dpkg --print-architecture)
# Signed-By: /etc/apt/keyrings/docker.asc
# EOF

sudo apt update
```

Install Docker:

``` bash
sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    #containerd.io \
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
## 4. Allow the current user to run Docker

Create the Docker group if necessary and add the current user:
```

sudo groupadd docker 2>/dev/null || true
sudo usermod -aG docker "$USER"
```

Apply the new group membership:

```
newgrp docker
```

Alternatively, log out and back in.

Verify that Docker works without sudo:

```
docker run --rm hello-world
```

The Docker group grants root-equivalent access to the Docker daemon, so membership should only be given to trusted users.

Verify Buildx:

```
docker buildx version
```



## 5. Install and authenticate GitHub CLI

Install GitHub CLI if it is not already present:

```
sudo apt install -y gh
```

Authenticate on the host:

```
gh auth login
```

Verify access to the target repository:

```
gh auth status
gh repo view ARIS-Robotics/classification
```

The second command must succeed before continuing.

If the repository belongs to an organization using SSO, ensure the selected token or GitHub CLI login is authorized for that organization.

## 6. Install Claude Code and create an OAuth token

Install Claude Code according to its current installation instructions.

Verify:

```
claude --version
```

Generate a Claude Code subscription token:

```
claude setup-token
```

Copy the generated value somewhere temporary and secure. It will later be added to `.sandcastle/.env`.

## 7. Enter the project repository

```
cd /path/to/classification
```

For example:

```
cd ~/cloud/ARIS/repositories/classification
```

Verify the repository:

```
git status
git remote -v
```

## 8. Initialize the local Node package

A Python repository may not already contain `package.json`.

Create one if necessary:

```
npm init -y
```

Install Sandcastle and `tsx` locally:

```
npm install --save-dev \
    @ai-hero/sandcastle \
    tsx
```

Installing Sandcastle locally ensures that the version is recorded in `package.json` and `package-lock.json`.

## 9. Initialize Sandcastle

Run:

```
npx @ai-hero/sandcastle@latest init
```

Choose:

```
Agent:             Claude Code
Sandbox provider: Docker
Issue tracker:     GitHub Issues
Template:          sequential-reviewer
Create label:      Yes
Build image now:   Yes
```

Do not choose `Custom` unless a custom issue tracker is intentionally being implemented. The custom option creates an incomplete configuration that must be wired manually. Sandcastle’s built-in templates include `simple-loop`, `sequential-reviewer`, and parallel workflows.

The generated directory should resemble:

```
.sandcastle/
├── Dockerfile
├── main.mts
├── prompt.md
├── CODING_STANDARDS.md
├── .env.example
└── ...
```

The default Docker image includes Node.js, Git, `jq`, GitHub CLI, Claude Code, and a non-root `agent` user.

## 10. Create the Sandcastle environment file

Copy the example instead of renaming it:

```
cp .sandcastle/.env.example .sandcastle/.env
```

Using `cp` preserves the example file for documentation.

Edit the environment file:

```
nano .sandcastle/.env
```

Set:

```
CLAUDE_CODE_OAUTH_TOKEN=<new-claude-token>
GH_TOKEN=<new-github-token>
```

Do not paste previously exposed tokens.

### GitHub token permissions

For a fine-grained GitHub token, grant access only to the intended repository.

At minimum, the GitHub Issues workflow normally needs:

```
Metadata: Read
Issues: Read and write
Contents: Read and write
```

`Contents: Read and write` may be necessary when the agent pushes branches or otherwise interacts with repository contents through GitHub.

If the workflow only operates on local branches and does not push, narrower permissions may work.

Verify the token before running Sandcastle:

```
GH_TOKEN="$(grep '^GH_TOKEN=' .sandcastle/.env | cut -d= -f2-)" \
    gh repo view ARIS-Robotics/classification
```

Also verify issue access:

```
GH_TOKEN="$(grep '^GH_TOKEN=' .sandcastle/.env | cut -d= -f2-)" \
    gh issue list \
    --repo ARIS-Robotics/classification \
    --state open \
    --limit 5
```

## 11. Protect the environment file

Add the private environment file to `.gitignore`:

```
grep -qxF '.sandcastle/.env' .gitignore ||
    echo '.sandcastle/.env' >> .gitignore
```

Also ignore Node dependencies:

```
grep -qxF 'node_modules/' .gitignore ||
    echo 'node_modules/' >> .gitignore
```

Confirm the secret file is ignored:

```
git check-ignore -v .sandcastle/.env
```

Never commit:

```
.sandcastle/.env
node_modules/
```

Normally commit:

```
.sandcastle/Dockerfile
.sandcastle/main.mts
.sandcastle/prompt.md
.sandcastle/CODING_STANDARDS.md
.sandcastle/.env.example
package.json
package-lock.json
```

## 12. Add the npm script

Add the Sandcastle command:

```
npm pkg set scripts.sandcastle="tsx .sandcastle/main.mts"
```

Verify:

```
cat package.json
```

It should include:

```
{
  "scripts": {
    "sandcastle": "tsx .sandcastle/main.mts"
  },
  "devDependencies": {
    "@ai-hero/sandcastle": "^0.12.0",
    "tsx": "^4.23.1"
  }
}
```

The precise versions may be newer on another machine.

## 13. Build or rebuild the Sandcastle image

The init process may already have built it.

List matching images:

```
docker images --format \
    "table {{.Repository}}\t{{.Tag}}\t{{.ID}}" |
    grep sandcastle
```

For the classification repository, the image may be named:

```
sandcastle:classification
```

To rebuild through the local CLI:

```
npx @ai-hero/sandcastle docker build-image
```

Do not run:

```
sandcastle docker build-image
```

unless Sandcastle was installed globally. A local installation is normally invoked with `npx`, `npm exec`, or an npm script.

## 14. Test GitHub authentication inside the image

The image’s default entrypoint may be `sleep`, so running the image with `bash` as a normal argument can produce:

```
sleep: invalid time interval 'bash'
```

Override the entrypoint:

```
docker run \
    --rm \
    -it \
    --entrypoint bash \
    --env-file .sandcastle/.env \
    sandcastle:classification
```

Inside the container, test:

```
gh auth status
gh repo view ARIS-Robotics/classification

gh issue list \
    --repo ARIS-Robotics/classification \
    --state open \
    --label Sandcastle \
    --limit 5
```

Exit:

```
exit
```

If `gh auth status` reports that no GitHub hosts are authenticated, confirm that:

1. `.sandcastle/.env` contains a valid `GH_TOKEN`.
2. `main.mts` loads the environment file.
3. The Docker provider forwards the environment to the sandbox.
4. The token has access to the private organization repository.
5. The token is authorized for organizational SSO, when applicable.

## 15. Customize the workflow

Review:

```
.sandcastle/main.mts
.sandcastle/prompt.md
.sandcastle/CODING_STANDARDS.md
.sandcastle/Dockerfile
```

Add project-specific Python dependencies and tools to the Dockerfile if the coding agent needs them.

For example, the container may need:

```
Python
uv
project system packages
test dependencies
formatters
linters
```

After changing the Dockerfile, rebuild:

```
npx @ai-hero/sandcastle docker build-image
```

## 16. Create a GitHub issue for Sandcastle

Create or choose an issue in the repository.

Apply the label:

```
Sandcastle
```

The scaffolded GitHub Issues templates filter the issue list using this label.

Verify:

```
gh issue list \
    --repo ARIS-Robotics/classification \
    --state open \
    --label Sandcastle
```

## 17. Run Sandcastle

From the repository root:

```
npm run sandcastle
```

Example output:

```
=== Iteration 1/10 ===

[implementer] Started on branch
sandcastle/sequential-reviewer/<run-id>
```

Monitor the log shown in the output:

```
tail -f .sandcastle/logs/<log-file>.log
```

Avoid terminating the process with `Ctrl+C` unless you intentionally want to stop the run.

The current sequential-reviewer workflow creates an issue-specific branch and runs implementation and review in the same sandbox. Recent Sandcastle changes also fixed issue selection and closure behavior in that template.

## 18. Inspect generated branches and commits

List Sandcastle branches:

```
git branch --all --list '*sandcastle*'
```

View recent history across all branches:

```
git log \
    --all \
    --oneline \
    --decorate \
    --graph \
    -30
```

Search for a particular commit message across all branches:

```
git log \
    --all \
    --grep="search text" \
    --oneline \
    --decorate \
    -i
```

Inspect a Sandcastle branch:

```
git log \
    --oneline \
    HEAD..sandcastle/sequential-reviewer/<run-id>
```

Compare it with the current branch:

```
git diff \
    HEAD...sandcastle/sequential-reviewer/<run-id>
```

## 19. Merge the completed changes

First switch to the target working branch:

```
git switch ap/audit-single-script
```

Merge the Sandcastle branch:

```
git merge \
    --no-ff \
    sandcastle/sequential-reviewer/<run-id>
```

Run the project tests and inspect the result:

```
git status
git log --oneline --decorate --graph -15
```

After confirming the merge, delete the local Sandcastle branch:

```
git branch -d sandcastle/sequential-reviewer/<run-id>
```

Alternatively, push the Sandcastle branch and open a pull request:

```
git push \
    -u origin \
    sandcastle/sequential-reviewer/<run-id>
```

```
gh pr create \
    --base ap/audit-single-script \
    --head sandcastle/sequential-reviewer/<run-id> \
    --title "Implement Sandcastle issue" \
    --body "Implements the selected Sandcastle issue."
```

## 20. Files to transfer to another machine

When Sandcastle has already been configured and committed in the repository, the second machine should receive these through Git:

```
.sandcastle/
package.json
package-lock.json
.gitignore
```

The second machine should not receive:

```
.sandcastle/.env
node_modules/
```

On the second machine, after cloning the repository:

```
npm install
cp .sandcastle/.env.example .sandcastle/.env
```

Add fresh machine-specific secrets to `.sandcastle/.env`, verify Docker, rebuild the image, and run:

```
npx @ai-hero/sandcastle docker build-image
npm run sandcastle
```

## Condensed installation checklist

```
# Install Node 22
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
source ~/.zshrc
nvm install 22
nvm use 22
nvm alias default 22

# Enter repository
cd /path/to/repository

# Install local dependencies
npm init -y
npm install --save-dev @ai-hero/sandcastle tsx

# Initialize Sandcastle
npx @ai-hero/sandcastle@latest init

# Add run script
npm pkg set scripts.sandcastle="tsx .sandcastle/main.mts"

# Create private environment
cp .sandcastle/.env.example .sandcastle/.env
nano .sandcastle/.env

# Protect secrets
echo '.sandcastle/.env' >> .gitignore
echo 'node_modules/' >> .gitignore

# Verify and build
docker run --rm hello-world
npx @ai-hero/sandcastle docker build-image

# Run
npm run sandcastle
```

Docker group:
`usermod -aG docker "$USER"` adds your user to the `docker` group permanently. `newgrp docker` does **not** make a global permanent change; it starts a new shell with refreshed group membership.

That is why it can seem to “keep happening” in other terminals or shells opened before the group change.

Check whether your account is permanently in the group:

```
getent group docker
groups "$USER"
```

You should see your username listed under `docker`.

```
 hello-world
```
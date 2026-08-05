---
created: 2026-06-09
tags:
  - ARIS
source:
aliases:
---
start up:
```
APP="$HOME/wade-system"
cat /etc/os-release | grep PRETTY_NAME
hostname
sudo journalctl -u state-machine.service -f


```




full report:
```
# Service logs
sudo journalctl -u state-machine.service --since today

# All manual logs
rg $(date -Is | cut -dT -f1) --no-ignore $APP_DIR
```

htop


## Installs
```
sudo apt get install htop
sudo apt get install fd-find
sudo apt get install ripgrep
sudo snap install chezmoi --classic
```






.bashrc

``` bash
alias press_button=''

APP_DIR=/home/aris/wade-system

latest_log=$(
  find ~/wade-system/data/logging/inference \
    -maxdepth 1 -type f -name 'Inferences_*_W*.log' \
    -print | sort -V | tail -n 1
)
latest_use_date=$(tail -n 1 "$latest_log" | cut -d_ -f3 | cut -dT -f1)
latest_use_time=$(
  tail -n 1 "$latest_log" |
  grep -oE '[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{3}' |
  head -n 1 |
  sed -E 's/^([0-9]{2})-([0-9]{2})-([0-9]{2})-([0-9]{3})$/\1:\2:\3.\4/'
)
version_number=$(grep -oP 'version="\K[^"]+' "$APP_DIR/setup.py")


alias logs_today='rg $(date -Is | cut -dT -f1) --no-ignore $APP_DIR'




```

Make a welcome print out when a user logs on:

OS: Ubuntu 22.04.4 LTS
Machine: fierce-wolf $(hostname)
System version: 2.4.30 $(version_number)
Storage left: 18G
Uptime: 54 days 12 hours
Last use: 2026-08-05 14:05:23.935


## Chat suggestion

```bash

# ---------------------------------------------------------------------------- #
#                                   Variables                                  #
# ---------------------------------------------------------------------------- #
APP_DIR="$HOME/wade-system"
INFERENCE_LOG_DIR="$APP_DIR/data/logging/inference"



# ---------------------------------------------------------------------------- #
#                                   Functions                                  #
# ---------------------------------------------------------------------------- #
# --------------------------- Print logs for today --------------------------- #
logs_today() {
    rg \
        --fixed-strings \
        --no-ignore \
        "$(date +%F)" \
        "$APP_DIR"
}

# ----------------------- Print logs for specific date ----------------------- #
logs_date() {
    local search_date="${1:-$(date +%F)}"

    rg \
        --fixed-strings \
        --no-ignore \
        "$search_date" \
        "$APP_DIR"
}

# --------------------------------- WADE Help -------------------------------- #
wade_help() {
    printf '\n'
    printf 'Common Wade debugging commands\n'
    printf '==============================\n\n'

    printf '%s\n' \
        'Service logs since today:' \
        '  sudo journalctl -u state-machine.service --since today' \
        '' \
        'Search all logs from today:' \
        '  logs_today' \
        '' \
        'Search logs from a particular date:' \
        '  logs_date YYYY-MM-DD' \
        '  Example: logs_date 2026-08-04' \
        '' \
        'Simulate pressing the button:' \
        '  press_button'

    printf '\n'
}

# -------------------------------- WADE Status ------------------------------- #
wade_status() {
    local latest_log
    local latest_line
    local timestamp
    local last_use
    local version_number
    local os_name
    local storage_left
    local uptime_text

    latest_log=$(
        find "$INFERENCE_LOG_DIR" \
            -maxdepth 1 \
            -type f \
            -name 'Inferences_*_W*.log' \
            -print 2>/dev/null |
        sort -V |
        tail -n 1
    )

    if [[ -n "$latest_log" && -r "$latest_log" ]]; then
        latest_line=$(tail -n 1 "$latest_log")

        timestamp=$(
            grep -oE \
                '[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{3}' \
                <<< "$latest_line" |
            head -n 1
        )

        last_use=$(
            sed -E \
                's/T([0-9]{2})-([0-9]{2})-([0-9]{2})-([0-9]{3})$/ \1:\2:\3.\4/' \
                <<< "$timestamp"
        )
    else
        last_use="No inference logs found"
    fi

    version_number=$(
        sed -nE \
            's/^[[:space:]]*version[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/p' \
            "$APP_DIR/setup.py" |
        head -n 1
    )

    os_name=$(
        . /etc/os-release
        printf '%s' "$PRETTY_NAME"
    )

    storage_left=$(
        df -h --output=avail "$APP_DIR" |
        tail -n 1 |
        xargs
    )

    uptime_text=$(uptime -p | sed 's/^up //')

# -- Print out -- #

printf '\n'
printf '%-18s %s\n' \
    'OS:'               "$os_name" \
    'Storage left:'     "$storage_left" \
    'Memory available:' "$(free -h | awk '/^Mem:/ {print $7}')" \
    'Uptime:'           "$uptime_text"

printf '\n'

printf '%-18s %s\n' \
    'Machine:'          "$(hostname)" \
    'System version:'   "${version_number:-unknown}" \
    'Git branch:'       "$(git -C "$APP_DIR" branch --show-current 2>/dev/null)" \
    'Last use:'         "${last_use:-unknown}"

printf '\n'
printf 'For common machine debugging commands, run:\n'
printf '  wade_help\n'
printf '\n'
}


# ----------------------------------- Alias ---------------------------------- #
alias press_button='touch /tmp/wade/ipfc/BUTTON.ipfc'





# Logging the status of the machine when a new shell is opened
case $- in
    *i*) wade_status ;;
esac




```




Typical chezmoi workflow
```bash
chezmoi init
chezmoi add ~/.bashrc
chezmoi add ~/.config/some-app/config.yaml
chezmoi diff
chezmoi apply
chezmoi cd
git remote add origin git@github.com:YOUR_ORG/production-dotfiles.git
git add .
git commit -m "Add production shell configuration"
git push -u origin main
```

On another machine:

```bash
chezmoi init git@github.com:YOUR_ORG/production-dotfiles.git
chezmoi diff
chezmoi apply
```
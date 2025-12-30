Install java
```bash
sudo apt install default-jdk
```


**Docker minecraft server**
Docker compose yaml file:
```YAML
services:
  mc:
    image: itzg/minecraft-server:latest
    pull_policy: daily
    tty: true
    stdin_open: true
    ports:
      - "25565:25565"
      - "25575:25575"
    environment:
      EULA: "TRUE"
      TYPE: PAPER
      OPS: |
        MegaMagn
      ENABLE_RCON: "true"
      RCON_PASSWORD: "changeme"   # pick a real password
      RCON_PORT: 25575
      CREATE_CONSOLE_IN_PIPE: "true"
    volumes:
      - ./data:/data   
  

# MINECRAFT DASHBOARD
  mc-dashboard:
    build: ./mc-dashboard
    ports:
      - "8090:8090"     # Web UI on http://server-ip:8090
    environment:
      RCON_HOST: mc
      RCON_PORT: 25575
      RCON_PASSWORD: changeme     # must match mc env
      PUSHOVER_USER: "usozo22dr29waq7yx9f5u3ab74717x"
      PUSHOVER_TOKEN: "at2di7dvcc9gsds3f73cfo6rbcw77r"
    depends_on:
      - mc
    volumes:
      - ./data/logs/latest.log:/mc-latest.log:ro   # <--- change to this
```

Commands can be send to the minecraft server with the `docker exec` command:
```bash
docker exec <mc server container name> rcon-cli <minecraft server command>
# Example
docker exec minecraft_server-mc-1 rcon-cli "say hello"
```


### Suspend server when empty
This script will be used in combination with a cron job to schedule a suspension of the server when no one is on the minecraft server.

```bash
#!/usr/bin/env bash
set -euo pipefail

out=$(docker exec minecraft_server-mc-1 rcon-cli "list" 2>/dev/null || true)

echo $out | wall

# Extract the first integer from the output (players online). Default to 0 if missing.
players=$(grep -oE '[0-9]+' <<< "$out" | awk 'NR==3')
players=${players:-0}

if [[ "$players" -eq 0 ]]; then
  echo "Suspending server." | wall

  # Set an RTC alarm for 07:00, then suspend the system now
  rtcwake -m mem -t "$(date -d 'tomorrow 7:00' +%s)"

  docker exec minecraft_server-mc-1 rcon-cli "say Suspending server waking up again at 7:00" 2>/dev/null || true
fi

echo $players found online | wall
```

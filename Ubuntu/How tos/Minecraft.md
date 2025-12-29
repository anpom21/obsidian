Install java
```
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


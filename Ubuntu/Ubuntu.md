- [SSH](SSH.md)
- 


## Keychron K10 v2 Bluetooth issues

See issue [here](https://gist.github.com/andrebrait/961cefe730f4a2c41f57911e6195e444#enable-bluetooth-fast-connect-config)
1. Edit the file `/etc/bluetooth/main.conf`
2. Uncomment FastConnectable config and set it to true: `FastConnectable = true`
3. Uncomment `ReconnectAttempts=7` (set the value to whatever number that you want)
4. Uncomment `ReconnectIntervals=1, 2, 3`
5. Run: `sudo systemctl restart bluetooth`
6. 
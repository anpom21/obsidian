## FPS Limiter
### Ubuntu
1. Clone fps strangle ([link](https://github.com/milaq/libstrangle))
```
git clone https://github.com/milaq/libstrangle
cd libstrangle
```

2. Install the build package `libc6-dev-i386`
```
sudo apt install libc6-dev-i386
```
3. Make and install
```
make
sudo make install
```
4. Set fps limit
For every game you need to do this step.
Go to steam right-click on a game in your **library** and selecting **Properties** , then go to **General** then set **launch** **options** to: `strangle <your desired fps limit> %command%`

5. When you are done you should have something like this:
![[Pasted image 20251212190407.png]]

## Frozen full screen

Harsh, but works:
```
loginctl terminate-user <user>
```

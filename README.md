 install

```shell
pacman -S --needed git base-devel
git clone --depth 1 https://github.com/clldot/hypr ~/HyDE
cd ~/HyDE/Scripts
./install.sh
```

Update

```shell
cd ~/HyDE/Scripts
git pull origin master
./install.sh -r
```


#!/usr/bin/env bash

if ($(which pacman > /dev/null )) ; then
  # ArchLinux install
  echo "To implement arch install"
  exit 1
elif ($(which apt > /dev/null )) ; then
  # Debian/Ubuntu install
  sudo apt install -y vim nitrogen git build-essential xinit x11-xserver-utils \
                      libx11-dev libxinerama-dev sharutils suckless-tools \
                      libxft-dev
else
  echo "Couldn't found a valid package manager"
  exit 1
fi

cd $HOME
mkdir -p dwm
cd dwm
[[ ! -d ~/dwm/dwm-flexipatch ]] && git clone https://github.com/bakkeby/dwm-flexipatch.git
[[ ! -d ~/dwm/st-flexipatch ]] && git clone https://github.com/bakkeby/st-flexipatch.git
[[ ! -d ~/dwm/dmenu-flexipatch ]] && git clone https://github.com/bakkeby/dmenu-flexipatch.git

# Enable patches
sed -i 's/BAR_POWERLINE_STATUS_PATCH 0/BAR_POWERLINE_STATUS_PATCH 1/' dwm-flexipatch/patches.h
# Config
cp -R $HOME/.config/dwm/* dwm-flexipatch
cp -R $HOME/.config/st/* st-flexipatch

cd dwm-flexipatch
make
sudo make clean install

cd ../st-flexipatch
make
sudo make clean install

cd ../dmenu-flexipatch
make
sudo make clean install

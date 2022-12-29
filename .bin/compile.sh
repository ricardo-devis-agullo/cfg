#!/usr/bin/env bash

sudo apt install -y vim nitrogen git build-essential xinit x11-xserver-utils \
                    libx11-dev libxinerama-dev sharutils suckless-tools \
                    libxft-dev

cd $HOME
mkdir -p dwm
cd dwm
[[ ! -d ~/dwm/dwm-flexipatch ]] && git clone https://github.com/bakkeby/dwm-flexipatch.git
[[ ! -d ~/dwm/st-flexipatch ]] && git clone https://github.com/bakkeby/st-flexipatch.git

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
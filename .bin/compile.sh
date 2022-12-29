#!/usr/bin/env bash

sudo apt install -y vim nitrogen git build-essential xinit x11-xserver-utils \
                    libx11-dev libxinerama-dev sharutils suckless-tools \
                    libxft-dev

cd $HOME
if [ -d "$DIR" ]; then
  echo "DWM folder already exists"
  exit 1
else
  mkdir dwm
  cd dwm
  git clone https://github.com/bakkeby/dwm-flexipatch.git
  git clone https://github.com/bakkeby/st-flexipatch.git

  # Enable patches
  sed -i 's/BAR_POWERLINE_STATUS_PATCH 0/BAR_POWERLINE_STATUS_PATCH 1/' dwm-flexipatch/patches.h
  # Themes
  cp -R $HOME/.config/dwm/themes dwm-flexipatch

  cd dwm-flexipatch
  make
  sudo make clean install

  cd ../st-flexipatch
  make
  sudo make clean install
fi
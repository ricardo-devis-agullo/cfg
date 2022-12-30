#!/usr/bin/env bash

if ($(which pacman > /dev/null )) ; then
  # ArchLinux install
  echo "To implement arch install"
  exit 1
elif ($(which apt > /dev/null )) ; then
  # Debian/Ubuntu install
  sudo apt install -y vim nitrogen git build-essential xinit x11-xserver-utils \
                      libx11-dev libxinerama-dev sharutils suckless-tools \
                      libxft-dev qutebrowser firefox neofetch fonts-liberation \
                      fonts-jetbrains-mono mpv

  # To compile wired
  sudo apt install -y librust-pangocairo-dev libdbus-1-dev librust-glib-sys-dev \
                      librust-cairo-rs-dev libxss-dev libnotify-bin cargo
else
  echo "Couldn't found a valid package manager"
  exit 1
fi

if [[ ! -f ~/.vim/autoload/plug.vim ]] ; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

cd $HOME
mkdir -p dwm
cd dwm
[[ ! -d ~/dwm/dwm-flexipatch ]] && git clone https://github.com/bakkeby/dwm-flexipatch.git
[[ ! -d ~/dwm/st-flexipatch ]] && git clone https://github.com/bakkeby/st-flexipatch.git
[[ ! -d ~/dwm/dmenu-flexipatch ]] && git clone https://github.com/bakkeby/dmenu-flexipatch.git
[[ ! -d ~/dwm/wired-notify ]] && git clone https://github.com/Toqozz/wired-notify.git

# Enable patches
sed -i 's/SAVEFLOATS_PATCH 0/SAVEFLOATS_PATCH 1/' dwm-flexipatch/patches.h
sed -i 's/PERTAG_PATCH 0/PERTAG_PATCH 1/' dwm-flexipatch/patches.h
sed -i 's/SWAPFOCUS_PATCH 0/SWAPFOCUS_PATCH 1/' dwm-flexipatch/patches.h
sed -i 's/ATTACHABOVE_PATCH 0/ATTACHABOVE_PATCH 1/' dwm-flexipatch/patches.h
sed -i 's/FOCUSADJACENTTAG_PATCH 0/FOCUSADJACENTTAG_PATCH 1/' dwm-flexipatch/patches.h
sed -i 's/PUSH_NO_MASTER_PATCH 0/PUSH_NO_MASTER_PATCH 1/' dwm-flexipatch/patches.h
sed -i 's/CFACTS_PATCH 0/CFACTS_PATCH 1/' dwm-flexipatch/patches.h

sed -i 's/SCROLLBACK_PATCH 0/SCROLLBACK_PATCH 1/' st-flexipatch/patches.h
sed -i 's/SCROLLBACK_MOUSE_PATCH 0/SCROLLBACK_MOUSE_PATCH 1/' st-flexipatch/patches.h
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

cd ../wired-notify
cargo build --release
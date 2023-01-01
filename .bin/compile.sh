#!/usr/bin/env bash

WM_FOLDER=~/wm

function banner {
  echo
  echo "+------------------------------------------+"
  printf "| %-40s |\n" "`date`"
  echo "|                                          |"
  printf "|`tput bold` %-40s `tput sgr0`|\n" "$@"
  echo "+------------------------------------------+"
  echo
}

function install_packages {
  banner "Installing packages"
  if ($(command -v pacman >/dev/null 2>&1 )) ; then
    # ArchLinux install
    sudo pacman --needed -S vim nitrogen git base-devel libx11 xorg-xinit xorg \
                            qutebrowser firefox neofetch ttf-liberation \
                            ttf-jetbrains-mono mpv ranger zip
  elif ($(command -v apt >/dev/null 2>&1 )) ; then
    # Debian/Ubuntu install
    sudo apt install -y vim nitrogen git build-essential xinit x11-xserver-utils \
                        libx11-dev libxinerama-dev sharutils suckless-tools \
                        libxft-dev qutebrowser firefox neofetch fonts-liberation \
                        fonts-jetbrains-mono mpv ranger zip
  else
    echo "Couldn't found a valid package manager"
    exit 1
  fi
}



function yay_install {
  if (! $(command -v yay >/dev/null 2>&1 )) ; then
    cd $HOME
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si
  fi
}

function install_wired_notify {
  if (! $(command -v wired >/dev/null 2>&1 )) ; then
    banner "Installing wired-notify"
    if ($(command -v pacman >/dev/null 2>&1 )) ; then
      yay_install
      yay -S wired
    elif ($(command -v apt >/dev/null 2>&1 )) ; then
      sudo apt install -y librust-pangocairo-dev libdbus-1-dev librust-glib-sys-dev \
                          librust-cairo-rs-dev libxss-dev libnotify-bin cargo
      mkdir -p $WM_FOLDER
      cd $WM_FOLDER
      [[ ! -d $WM_FOLDER/wired-notify ]] && git clone https://github.com/Toqozz/wired-notify.git
      cd wired-notify
      cargo build --release
      sudo cp $WM_FOLDER/wired-notify/target/release/wired /usr/local/bin
    fi
  fi

  cp $HOME/.config/wired/wired.ron_tokyo $HOME/.config/wired/wired.ron
}

function install_dwm {
  banner "Installing dwm"
  mkdir -p $WM_FOLDER
  cd $WM_FOLDER
  [[ ! -d $WM_FOLDER/dwm-flexipatch ]] && git clone https://github.com/bakkeby/dwm-flexipatch.git

  # Enable patches
  cp dwm-flexipatch/patches.def.h dwm-flexipatch/patches.h
  sed -i 's/SAVEFLOATS_PATCH 0/SAVEFLOATS_PATCH 1/' dwm-flexipatch/patches.h
  sed -i 's/PERTAG_PATCH 0/PERTAG_PATCH 1/' dwm-flexipatch/patches.h
  sed -i 's/SWAPFOCUS_PATCH 0/SWAPFOCUS_PATCH 1/' dwm-flexipatch/patches.h
  sed -i 's/ATTACHABOVE_PATCH 0/ATTACHABOVE_PATCH 1/' dwm-flexipatch/patches.h
  sed -i 's/FOCUSADJACENTTAG_PATCH 0/FOCUSADJACENTTAG_PATCH 1/' dwm-flexipatch/patches.h
  sed -i 's/PUSH_NO_MASTER_PATCH 0/PUSH_NO_MASTER_PATCH 1/' dwm-flexipatch/patches.h
  sed -i 's/CFACTS_PATCH 0/CFACTS_PATCH 1/' dwm-flexipatch/patches.h

  # Config
  cp -R $HOME/.config/dwm/* dwm-flexipatch

  cd dwm-flexipatch
  make
  sudo make clean install
}

function install_st {
  banner "Installing st"
  mkdir -p $WM_FOLDER
  cd $WM_FOLDER
  [[ ! -d $WM_FOLDER/st-flexipatch ]] && git clone https://github.com/bakkeby/st-flexipatch.git

  # Enable patches
  cp st-flexipatch/patches.def.h st-flexipatch/patches.h
  sed -i 's/SCROLLBACK_PATCH 0/SCROLLBACK_PATCH 1/' st-flexipatch/patches.h
  sed -i 's/SCROLLBACK_MOUSE_PATCH 0/SCROLLBACK_MOUSE_PATCH 1/' st-flexipatch/patches.h

  # Config
  cp -R $HOME/.config/st/* st-flexipatch

  cd st-flexipatch
  make
  sudo make clean install
}

function install_dmenu {
  banner "Installing dmenu"
  mkdir -p $WM_FOLDER
  cd $WM_FOLDER
  [[ ! -d $WM_FOLDER/dmenu-flexipatch ]] && git clone https://github.com/bakkeby/dmenu-flexipatch.git

  cd dmenu-flexipatch
  make
  sudo make clean install
}

function configure_vim {
  if [[ ! -f ~/.vim/autoload/plug.vim ]] ; then
    banner "Configuring VIM"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
}

install_packages
configure_vim
install_dwm
install_st
install_dmenu
install_wired_notify

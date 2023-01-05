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
  # ArchLinux install
  sudo pacman --needed -S vim git base-devel libx11 xorg-xinit xorg \
                          qutebrowser firefox neofetch ttf-liberation \
                          ttf-jetbrains-mono mpv ranger zip pass youtube-dl
                          yay qt5-wayland vscode kitty wofi mako pipewire \
                          wireplumber polkit-kde-agent waybar pass swaybg \
                          swayidle

  yay -S hyprland hyprpaper-git ttf-work-sans swaylock-effects
}

function configure_vim {
  if [[ ! -f ~/.vim/autoload/plug.vim ]] ; then
    banner "Configuring VIM"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
}

function configure_qutebrowser {
  if [[ ! -d ~/.config/qutebrowser/catppuccin ]] ; then
    git clone https://github.com/catppuccin/qutebrowser.git ~/.config/qutebrowser/catppuccin
  else
    cd ~/.config/qutebrowser/catppuccin
    git pull
  fi
}

install_packages
configure_vim
configure_qutebrowser


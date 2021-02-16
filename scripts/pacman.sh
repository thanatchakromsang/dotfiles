#!/bin/bash

# Terminal packages
declare -a pkgs=("curl"
                 "sudo"
                 "networkmanager"
                 "pacman-contrib"
                 "inetutils"

                 "htop"
                 "yarn"
                 "zsh"

                 "tig"
                 "bat"
                 "exa"
                 "nnn"
                 "stow"
                 "fzf"
                 "lastpass-cli"
                 "ripgrep"
                 "wl-clipboard"
                 "terraform"
                 "openssh"

                 "yq"
                 "jq"

                 "docker"
                 "kubectl"
                 "helm"
                 "minikube"

                 # Bluetooth related packages
                 "bluez"
                 "bluez-utils"

                 "rustup"

                 # Network Utility
                 "bind"

                 "go"
                 "gcc"
                 "make"

                 "neovim"
                 "python-pip"
                 "python-neovim"

                 "virtualbox"

                 "playerctl"
                 )

# Graphic packages
declare -a g_pkgs=(
                   "zathura"
                   "zathura-pdf-mupdf"
                   "ranger"
                   "kitty"
                   "chromium"
                   "pipewire"
                   "libpipewire02" # Remove when Chromium support pipewire 0.3
                   "xdg-desktop-portal-wlr"
                   "telegram-desktop"

                   "light"

                   "grim"
                   "slurp"

                   "sway"
                   "swaybg"
                   "waybar"
                   "wf-recorder"
                   "swayidle"
                   "swaylock"

                   "mako" # Notification daemon

                   # Sound
                   "pavucontrol"
                   "pulseaudio-bluetooth"
                   "pulseaudio"

                   # Fonts
                   "ttf-dejavu"
                   "noto-fonts-emoji"

                   "polkit"
                   "polkit-gnome"
                   )

declare -a aur_pkgs=("zsh-plugin-wd-git"
                     "lazydocker"
                     "lazygit"
                     "pet-bin"
                     "rofi-lbonn-wayland-git"
                     "grimshot"
                     "networkmanager-dmenu-git"

                     "wdisplays"

                     # Fonts
                     "fonts-tlwg"
                     "nerd-fonts-hack"
                    )

yay -Syu ${pkgs[@]} ${g_pkgs[@]} ${aur_pkgs[@]} --noconfirm

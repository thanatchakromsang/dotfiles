#!/bin/bash

# TODO: reclassify pkgs
# Terminal packages
declare -a pkgs=(
	"curl"
	"sudo"
	"networkmanager"
	"pacman-contrib"
	"inetutils"
	"unzip"

	"htop"
	"yarn"
	"zsh"

	"neovim"
	"tig"
	"fd"
	"bat"
	"exa"
	"ranger" "ueberzug"
	"stow"
	"fzf"
	"lastpass-cli"
	"ripgrep"
	"wl-clipboard"
	"terraform"
	"openssh"
	"anki"

	"yq"
	"jq"

	# Bluetooth related packages
	"bluez" "bluez-utils"

	"rustup"

	# Network Utility
	"bind"

	"go"
	"gcc"
	"make"

	"python-pip"
	"python-pipenv"
	"python-neovim"

	"virtualbox"

	"playerctl"

	# LSP related
	"lua-language-server" "lua-format" # aur
	"efm-langserver"
	"rust-analyzer"
	"terraform-ls"
	"gopls"
	"shfmt" # shell fmt
	"shellcheck"

	# static-site-generator
	"hugo"
)

# Graphic packages
declare -a g_pkgs=(
	"zathura"
	"zathura-pdf-mupdf"
	"ranger"
	"kitty"
	"pipewire"
	"libpipewire02"          # TODO: Remove when Chromium support pipewire 0.3
	"pipewire-media-session" # FIX: Normoally not needed but pacman not provide dependencies https://github.com/emersion/xdg-desktop-portal-wlr/issues/97
	"xdg-desktop-portal-wlr"
	"telegram-desktop"

	"firefox"

	"light"
	"gammastep"

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
	# "pulseaudio-bluetooth"
	# "pulseaudio"
	"pipewire-pulse"
	"pipewire-alsa"

	# Fonts
	"ttf-dejavu"
	"noto-fonts-emoji"
	"otf-font-awesome"
	"ttf-font-awesome"

	"polkit"
	"polkit-gnome"
)

declare -a aur_pkgs=(
	"zsh-plugin-wd-git"
	"lazydocker"
	"lazygit"
	"pet-bin"
	"rofi-lbonn-wayland-git"
	"grimshot"
	"networkmanager-dmenu-git"
	"rofi-bluetooth-git"
	"bitwarden-rofi-git"

	"git-secret"

	"wdisplays"

	# "google-chrome"

	"downgrade"

	# Fonts
	"fonts-tlwg"
	"nerd-fonts-hack"
)

declare -a kube_pkgs=(
	"docker"
	"docker-compose"

	"k9s"
	"kubectl"
	"helm"
	"krew-bin"
	"kind-bin"
	"kubeseal"
	"kubefwd-bin"
	"flux-bin"
)

yay -Syu "${pkgs[@]}" "${g_pkgs[@]}" "${aur_pkgs[@]}" "${kube_pkgs[@]}" --noconfirm --needed

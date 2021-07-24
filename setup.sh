#!/bin/bash
# Output colors
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PINK="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
NORMAL="\033[0;39m"

OS="$(uname -a)"
DOTFILES=$HOME/.dotfiles

case "$OS" in
	*Darwin*)
		source "$DOTFILES"/scripts/macos/brew.sh
		source "$DOTFILES"/scripts/macos/macos-setting.sh
		echo "Restart macOS after installation"
		;;
	*arch*)
		sudo pacman -S git base-devel go --noconfirm
		git clone https://aur.archlinux.org/yay.git "$HOME"/.yay
		cd "$HOME"/.yay || return
		makepkg -si
		source "$DOTFILES"/scripts/archlinux/pacman.sh
		source "$DOTFILES"/scripts/archlinux/systemctl.sh
		source "$DOTFILES"/scripts/archlinux/arch-usergroups.sh
		source "$DOTFILES"/scripts/install-krew.sh
		;;
esac

source "$DOTFILES"/scripts/oh-my-zsh.sh
source "$DOTFILES"/scripts/lsp.sh

# Remove default zshrc
rm -f "$HOME"/.zshrc

# Symlink conf
source "$DOTFILES"/stow.sh

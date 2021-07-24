#!/usr/bin/env bash

OS="$(uname -a)"
DOTFILES=$HOME/.dotfiles
STATE=$HOME/.dotstate

if [ -f "$STATE" ]; then
	echo -e
	echo -e
	echo -e "/////////////////////////////////"
	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "//    Unsymlinks using stow..  //"
	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "//                             //"

	stow -v -D -t "$HOME" @general
	case "$OS" in
		*Darwin*)
			stow -v -D -t "$HOME" @macos --adopt
			;;
		*Linux*)
			stow -v -D -t "$HOME" @linux --adopt
			sudo cp $DOTFILES/@linux/.config/pacman.conf /etc/pacman.conf
			;;
	esac

	# Remove dotfiles symlink state
	rm -f $STATE

	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "/////////////////////////////////"
	echo -e
	echo -e
else
	echo -e
	echo -e
	echo -e "/////////////////////////////////"
	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "//    symlinks using stow..    //"
	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "//                             //"

	stow -v -t "$HOME" @general
	case "$OS" in
		*Darwin*)
			stow -v -t "$HOME" @macos
			;;
		*Linux*)
			stow -v -t "$HOME" @linux
			;;
	esac

	# Create dotfiles symlink state
	touch $STATE

	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "//                             //"
	echo -e "/////////////////////////////////"
	echo -e
	echo -e
fi

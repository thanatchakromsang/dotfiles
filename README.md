# Dotfiles

My unix dotfiles for Archlinux

- neovim, kitty and zsh
- sway (mako, waybar, swaylock, rofi)

## __Installation__

```bash
sudo pacman -S git

git clone https://github.com/thanatchakromsang/dotfiles.git ~/.dotfiles
```

## git secret

### Import GPG public/private key

Import those 2 for ability to encrypt and decrypt secret files

```bash
gpg --import public.gpg
gpg --import private.gpg
```

### Reveal Secret

Some configuration needed to be encrypted because personal information. In that
case we need to decrypt secret using following

```bash
git secret reveal
```

### Hide Secret

Hide secret after some changes. Usually we don't need to do this because git-hooks
will take care of precommit hide secret after installation

```bash
git secret hide
```

## Installation

```bash
~/.dotfiles/setup.sh
```

## Upgrade Packages

```bash
~/.dotfiles/upgrade.sh
```

## Google Chrome Desktop Application on wayland

- After add desktop application need to modify it a bit in `~/.local/share/applications`

eval $(ssh-agent)
export PATH="$HOME/.dotfiles/scripts/bin:$PATH"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CURRENT_DESKTOP=sway
export MOZ_ENABLE_WAYLAND=1

if [[ ! $DISPLAY && XDG_VTNR -le 2 ]]; then
  exec sway
fi

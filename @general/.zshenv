#!/bin/sh

source $HOME/.dotfiles/scripts/bin/exists.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Local variables
if exists nvim; then
  export VISUAL=nvim
else
  export VISUAL=vim
fi
export EDITOR=$VISUAL
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color

export HISTCONTROL=ignoredups
export HISTFILESIZE=50000
export SSH_KEY_PATH="$HOME/.ssh"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/.dotfiles/scripts/bin:$PATH"

export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"

# Program specific
export CLOUDSDK_HOME=$CLOUDSDK_ROOT_DIR

export PATH="$(yarn global bin):$PATH"
export PATH="$(npm config get prefix)/bin:$PATH"

if exists fzf; then
  export FZF_DEFAULT_OPTS='--height 40% --border --reverse'
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  # fzf color
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#d5c4a1,bg:#282828,hl:#fbf1c7 --color=fg+:#d5c4a1,bg+:#7c6f64,hl+:#d79921 --color=info:#928374,prompt:#d79921,pointer:#d79921 --color=marker:#d79921,spinner:#cc241d,header:#458588'
fi

# OS Specific
case "$(uname -a)" in
  *Darwin*)
    export PATH="/usr/local/bin/:$PATH"
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    export PATH="/usr/local/opt/python@3.8/bin:$PATH"
    ;;
  *arch*)
    ;;
  *Ubuntu|Debian*)
    ;;
esac

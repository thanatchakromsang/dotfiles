#!/bin/sh

# Remote server environmental variables
if [[ -n $SSH_CONNECTION ]] ; then
    export TERM=xterm-256color
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Local variables
  export VISUAL=nvim
  export EDITOR=$VISUAL
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
  export PATH=~/.local/bin/:$PATH
  export NVM_DIR="$HOME/.nvm"
  export TERM=xterm-256color

# SSH_KEY
  export SSH_KEY_PATH="~/.ssh"

  export FZF_DEFAULT_OPTS='--height 100% --border --preview "[[ $(file --mime {}) =~ binary ]] &&
                 echo {} is a binary file ||
                 (highlight -O ansi -l {} ||
                  coderay {} ||
                  rougify {} ||
                  cat {}) 2> /dev/null | head -500" --preview-window top'
  export FZF_DEFAULT_COMMAND='
    (git ls-tree -r --name-only HEAD ||
     find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
        sed s/^..//) 2> /dev/null'
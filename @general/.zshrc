# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOTFILES=$HOME/.dotfiles
export ZSH="$HOME/.oh-my-zsh"

# # Show startup logo only when appropriate
# if [[ $(tput cols) -gt 90 && $(tput lines) -gt 19 ]]; then
#   source $DOTFILES/zsh/startup.sh
# fi

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  yarn
  docker
  node
  npm
  tig
  kubectl
  dotenv
  wd
  fzf
  helm
  rust
)

OS="$(uname -a)"
case "$OS" in
  *Darwin*)
    source /etc/profile
  ;;
esac

source $ZSH/oh-my-zsh.sh

# source useful script
source $DOTFILES/scripts/bin/exists.sh

source $DOTFILES/@general/.aliases
source $DOTFILES/@general/.zshenv

# bind alt meta
bindkey '^[k' clear-screen

# bind ctrl meta
bindkey '^ ' autosuggest-accept

# bindkey '^M' autosuggest-execute
bindkey '^p' up-line-or-beginning-search
bindkey '^n' down-line-or-beginning-search
bindkey '^o' vi-forward-word
bindkey '^H' backward-kill-word

# Pet binding
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon <$TTY >$TTY

bindkey '^s' pet-select

set -o ignoreeof

# fzf function

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
f() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0 --preview "([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200"))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# d - Find any directory and cd to selected directory
d() {
 local dir

 dir=$(fd --type d --hidden --follow --exclude .git 2> /dev/null | fzf +m --query="$1") &&
 cd "$dir"
}

w() {
  IFS=$'\n' files=($(rg --trim --line-number --hidden "$1" | fzf --delimiter=: --preview '([[ -f {1} ]] && (bat --style=numbers --line-range {2}: --highlight-line {2} --color=always {1} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'))


  # Open files with specific lines
  [[ -n "$files" ]] && ${EDITOR:-vim} +$(echo ${files[@]} | awk '{split($0,a,":"); print a[2] }') $(echo ${files[@]} | awk '{split($0,a,":"); print a[1] }')
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/thanatchaya/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/thanatchaya/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/thanatchaya/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/thanatchaya/google-cloud-sdk/completion.zsh.inc'; fi

if [ -f '/home/thanatchaya/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/thanatchaya/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#!/bin/bash

ZSH_CUSTOM="$HOME/.oh-my-zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/custom/plugins/zsh-syntax-highlighting"

git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/custom/plugins/zsh-autosuggestions"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

chsh -s "$(which zsh)"

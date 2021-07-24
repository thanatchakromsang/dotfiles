#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install grep
brew install openssh
brew install screen

# Install font tools.
brew install fontconfig

# Install other useful binaries.
declare -a bin=("git" "exa" "rg" "stow" "tig" "bat" "fzf" "lastpass-cli" "yq" "jq")

for i in "${bin[@]}"
do
   brew install "$i"
done


# development
declare -a dev=("node" "python3" "neovim" "tmux" "koekeishiya/formulae/yabai" "koekeishiya/formulae/skhd" "cmacrae/formulae/spacebar" "knqyf263/pet/pet" "ranger"  "jesseduffield/lazygit/lazygit" "jesseduffield/lazydocker/lazydocker")

for i in "${dev[@]}"
do
   brew install "$i"
done

# cask install
declare -a cask=("kitty")

for i in "${cask[@]}"
do
   brew cask install "$i"
done

# Autostart services
declare -a service=("skhd" "yabai" "spacebar")

for i in "${service[@]}"
do
  brew services start "$i"
done

# Remove outdated versions from the cellar.
brew cleanup

# Install fonts
brew tap homebrew/cask-fonts
brew cask install font-fantasque-sans-mono
brew cask install font-fontawesome
brew cask install font-fira-code
brew cask install font-awesome-terminal-fonts

if [[ $(program_is_installed fc-cache) -eq 1 ]]; then
  fc-cache $DOT/.font
fi

# # make sure rrdtool exists; else die with an error message
# type -P $RRDTOOL &>/dev/null || { echo "$RRDTOOL not found. Set \$RRDTOOL in $0"; exit 1; }

# # make sure dir exits; else create it
# [ -d $OUTDIR ] || mkdir -p $OUTDIR

# # make sure input file exits; else die with an error message
# [ -f $INFILE ] || { echo "$INFILE input file not found. set \$INFILE in $0"; exit 2; }

npm config set prefix $HOME/.local

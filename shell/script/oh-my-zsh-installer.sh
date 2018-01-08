#!/bin/bash

echo "install oh my zsh"
echo -n "answer 'y'es or 'n'o : "
read REPLY
if [[ "$REPLY" == "y" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins
    echo "setup oh my zsh complete"
    echo
else
    echo "aborted oh my zsh setup"
    echo
fi

#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "*** Symlinks QMK Profile... ***"
ln -s $DIR/users/thanatchaya $DIR/qmk/users

echo "*** Symlinks Keymap ***"
ln -s $DIR/ergodox-ez $DIR/qmk/keyboards/ergodox_ez/keymaps/thanatchaya
ln -s $DIR/keyboardio/atreus $DIR/qmk/keyboards/keyboardio/atreus/keymaps/thanatchaya
ln -s $DIR/crkbd $DIR/qmk/keyboards/crkbd/keymaps/thanatchaya

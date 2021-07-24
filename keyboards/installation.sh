#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "*** Initialize submodule... ***"
git submodule init
git submodule update --remote

echo "*** QMK Setup... ***"
python3 -m pip install --user qmk
qmk setup --home $DIR/qmk

echo "*** QMK Dependencies Setup... ***"
$DIR/qmk/util/qmk_install.sh

OS="$(uname -a)"

case "$OS" in
  *Darwin*)
    ;;
  *Linux*)
    ## https://docs.qmk.fm/#/faq_build?id=linux-udev-rules
    sudo cp $DIR/50-qmk.rules /etc/udev/rules.d/
    sudo cp $DIR/60-kaleidoscope.rules /etc/udev/rules.d/
    sudo udevadm control --reload-rules
    sudo udevadm trigger
    ;;
esac


#!/usr/bin/env sh

INTERN="eDP1"
DOTFILES=$HOME/.dotfiles

case "$1" in
    hdmi)
        EXTERN="HDMI1"
        EXTERN2="HDMI2"
        ;;
    rotate)
        IS_INVERTED=`xrandr --query | awk /^${INTERN}*/'{ print $5 }'`
        if [[ "${IS_INVERTED}" == "inverted" ]]; then
          xrandr --output $EXTERN --rotate normal
        else
          xrandr --output $EXTERN --rotate inverted
        fi
        ;;
    *)
esac

case "$2" in
    intern)
        xrandr --output $EXTERN --off --output $EXTERN2 --off --output $INTERN --auto
        sh $DOTFILES/.config/i3/random_wallpaper.sh
        i3-msg restart
        ;;
    extern)
        xrandr --output $EXTERN --auto --output $EXTERN2 --off --output $INTERN --off
        sh $DOTFILES/.config/i3/random_wallpaper.sh
        i3-msg restart
        ;;
    clone)
        CLONERES=`xrandr --query | awk '/^ *[0-9]*x[0-9]*/{ print $1 }' | sort -n | uniq -d | tail -1`
        xrandr --output $INTERN --mode $CLONERES --pos 0x0 --output $EXTERN --mode $CLONERES --pos 0x0 --output $EXTERN2 --off
        sh $DOTFILES/.config/i3/random_wallpaper.sh
        i3-msg restart
        ;;
    extend)
        xrandr --output $INTERN --auto --output $EXTERN --auto --left-of $INTERN --output $EXTERN2 --off
        sh $DOTFILES/.config/i3/random_wallpaper.sh
        i3-msg restart
        ;;
    *)
        usage
        ;;
esac

exit 0

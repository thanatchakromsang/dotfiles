#!/bin/sh

case "$1" in
    --toggle)
        if pgrep -x "gammastep" > /dev/null; then
          pkill gammastep;
        else
          exec gammastep &
        fi
        ;;
    *)
      if pgrep -x "gammastep" > /dev/null; then
        echo '{"alt": "on", "tooltip": "gammastep on"}'
      else
        echo '{"alt": "off", "tooltip": "gammastep off"}'
      fi
esac

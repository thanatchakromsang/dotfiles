#!/bin/sh
if [ $1 == "toggle" ];then
  for SOURCE in `pactl list sources | grep 'Name: ' | awk '{print $2}'`
  do
    pactl set-source-mute $SOURCE $1
  done
fi

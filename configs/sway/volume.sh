#!/bin/sh
if [ $1 == "toggle" ];then
  for SINK in `pactl list sinks | grep 'Sink' | cut -b7-`
  do
    pactl set-sink-mute $SINK $1
  done
else
  for SINK in `pactl list sinks | grep 'Sink' | cut -b7-`
  do
    pactl set-sink-volume $SINK $1
  done
fi

#!/bin/sh

if [ "$(playerctl -l)" == "playerctld" ]; then
    echo
elif [ $(playerctl status) != "Paused" ]; then
    title=$(playerctl metadata title)
    artist=$(playerctl metadata artist)
    echo "$title"
else
    echo "Paused"
fi

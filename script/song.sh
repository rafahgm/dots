#!/bin/sh

if [ "$(playerctl -l)" == "playerctld" ]; then
    echo
elif [ $(playerctl --player=spotify status) != "Paused" ]; then
    title=$(playerctl --player=spotify metadata title)
    artist=$(playerctl --player=spotify metadata artist)
    echo "$title by $artist"
else
    echo
fi

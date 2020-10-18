#!/bin/sh

if [ ! "$(playerctl -l | grep spotify)" ]; then
    echo
elif [ $(playerctl --player=spotify status) == "Playing" ]; then
    title=$(playerctl --player=spotify metadata title)
    artist=$(playerctl --player=spotify metadata artist)
    echo "$title by $artist"
else
    echo
fi

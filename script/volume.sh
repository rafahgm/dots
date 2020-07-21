#!/bin/sh

function vol() {
    amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }'
}

if [ $1 == "up" ]; then
    amixer -q sset Master 5%+
    vol=$(vol)
    notify-send "$vol+" -h string:x-canonical-private-synchronous:x -a 'Volume' -t 1000
elif [ $1 == "down" ]; then
    amixer -q sset Master 5%-
    vol=$(vol)
    notify-send "$vol-" -h string:x-canonical-private-synchronous:x -a 'Volume' -t 1000
elif [ $1 == "toggle" ]; then
    amixer -q sset Master toggle
    vol=$(vol)
    notify-send "Toggle" -h string:x-canonical-private-synchronous:x -a 'Volume' -t 1000
fi
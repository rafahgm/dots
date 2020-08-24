#!/bin/sh

eth="eno1"
wifi="wlan1"

check() {
    nmcli d status | grep -P "$1.+connected"
}

if [ "$(check $eth)" != "" ]; then
    echo 
elif [ "$(check $wifi)" != "" ]; then
    echo 
else
    echo 
fi

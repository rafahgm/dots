#!/bin/sh

s=$(protonvpn s | head -1 | awk '{print $2}')

if [ $s != "Disconnected" ]; then
    echo "VPN"
else
    echo ""
fi

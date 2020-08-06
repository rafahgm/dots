#!/bin/sh

# Brings up a list a of Bitwarden named passwords "Reddit, YouTube" etc., keeps the password in clipboard for 3 seconds
sh ~/.config/script/float.sh alacritty -d 60 1 -e $SHELL -c 'printf "Master password: " && read -s password && echo && export BW_SESSION=$(bw unlock --raw "$password") && if test "$BW_SESSION" = ""; then exit 1; fi && res=$(bw list items | jq -r ".[] | .name" | rofi -dmenu -i -p Passwords:) && bw get password "$res" | xclip -selection c && sleep 3'
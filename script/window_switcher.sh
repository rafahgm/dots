#!/bin/sh

#
#   BSPWM window switcher
#

bspc desktop -f VII

desktop_name=''
rofi=''

# Get the names of all desktops with the IDs of applications on those desktops
# Desktop names are prepended with an @ sign to show that they're desktop names
# Example output:
#   @I
#   123456
#   @II
#   234567
#   345678
output=$(bspc query -T -m | jq -r '.. | objects | "@\(select(.name!=null)|.name)", (select(.client!=null)|.id)' | tail -n +2)

# Loop through lines of the output adding them to a rofi list
for i in $output; do
    if [ ${i::1} = '@' ]; then
        desktop_name="${i#*@}"
    else
        rofi+="<!-- $i --> $desktop_name\t  $(xtitle $i)\n"
    fi
done

# Get the user selection from rofi list
selection=$(echo -e "$rofi" | head -n -1 | rofi -dmenu -markup-rows -p '  ')

# Switch to the ID of the chosen window
bspc node -f $(echo "$selection" | grep -oP '\d+' | head -n 1)

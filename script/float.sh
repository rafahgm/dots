#!/bin/sh

bspc rule -a \* -o state=floating && "$@"
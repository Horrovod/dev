#!/bin/sh

# убить старый процесс
killall waybar
waybar &
# отладка
#echo "worked $(date)" >> /home/deathdemise/github/repos/configs/waybar/scripts/test.log

# запустить с окружением
#env WAYLAND_DISPLAY=$WAYLAND_DISPLAY XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR waybar &

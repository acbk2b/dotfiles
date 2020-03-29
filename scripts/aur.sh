#/bin/bash

git clone https://aur.archlinux.org/$1.git ~/Documents/TMP/$1

cd ~/Documents/TMP/$1

makepkg -si

echo "Success!"

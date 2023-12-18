#! /usr/bin/bash
# TODO THIS SCRIPT IS A WORK IN PROGRESS, AND IS CURRENTLY MORE TO SERVE AS DOCUMENTATION, NOT MEANT TO BE RUN DIRECTLY

# Drive set up
SPIN1="$HOME/toshiba-drive"
SPIN2="$HOME/D"
# Cache set up
sudo echo "XDG_CACHE_HOME=\"${SPIN1}/.cache\"" >> /etc/profile
[ ! -d $HOME/.cache ] && mkdir -p $HOME/.cache
ln -s $SPIN1/.cache $HOME/.cache
# Documents/Downloads/Pictures
ln -s $SPIN1/Documents $HOME/docs
ln -s $SPIN1/Downloads $HOME/down
ln -s $SPIN1/Pictures $HOME/pics

# Create config directory
[ ! -d $HOME/.config ] && mkdir -p $HOME/.config
# Install base packages (yay required)
yay -S $(cat ./packages.txt)

# TODO alacritty Dracula alacritty theme
cd alacritty
wget https://github.com/dracula/alacritty/archive/master.zip
unzip ./master.zip
cd -

# Link all directories in .config
cd ./.config
for D in *; do
    ln -s $(pwd)/$D $HOME/.config
done
# Link all scripts in .local/bin
cd -
# Create $HOME/.local/bin if it doens't exist already
[ ! -d $HOME/.local/bin ] && mkdir -p $HOME/.local/bin
cd .local/bin
for S in *; do
    ln -s $(pwd)/$S $HOME/.local/bin
done

# Link (hidden) scripts in home directory
ln -s $(pwd)/.zshrc $HOME
ln -s $(pwd)/.zprofile $HOME

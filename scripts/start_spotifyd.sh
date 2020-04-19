# !/bin/bash

if [[ $1 == "-r" ]] 
then
    systemctl --user stop spotifyd.service
fi

# export bitwarden session key
$( bw unlock | grep -E "export BW_SESSION=.+" -o )

# pass spotify password from bitwarden to spotifyd
spotifyd -P 'bw get password spotify'

# start spotifyd dameon as system service
systemctl --user start spotifyd

# Lock Bitwarden Vault
bw lock

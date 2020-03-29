# !/bin/bash

# export bitwarden session key
$( bw unlock | grep -E "export BW_SESSION=.+" -o )
# pass spotify password from bitwarden to spotifyd
spotifyd -P 'bw get password spotify'
# start spotifyd dameon as system service
systemctl start spotifyd

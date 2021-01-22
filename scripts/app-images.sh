#! /bin/bash

USER=$( whoami )
APPIMAGEDIR="/home/$USER/toshiba-drive/applications"

$APPIMAGEDIR/$( ls $APPIMAGEDIR | dmenu -i )

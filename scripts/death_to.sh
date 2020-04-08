#! /bin/bash

PROCESSES=$(ps -d | grep -w $1 | grep -E "[[:digit:]]{3,5}" -o)

if [ "$PROCESSES" != "" ];
then
    kill $PROCESSES
    echo "Killed all processes for $1!"
else
    echo "No processes to kill!"
fi

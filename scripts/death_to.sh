kill $( ps -d | grep $1 | grep -E "[[:digit:]]{3,5}" -o )

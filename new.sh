#!/bin/bash

newfilename=$1
if [[ -z "$1" ]]; then
    echo No dir name provided, using "unnamed" as default
    newfilename="unnamed"
fi


dirs=$(ls -d */ | tr -d / | grep -Po "[0-9]+(?=-)")
# echo $dirs

sorted=$( printf "%s\n" "$dirs" | sort -n )
# printf "%s\n" "$sorted"
last=$(printf "%s\n" "$sorted" | tail -n 1)
# echo $last

lastnum=$(($last + 1))

echo Adding project \#$lastnum $newfilename

mkdir "$lastnum-$newfilename"


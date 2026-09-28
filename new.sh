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

lastnum=$(printf "%02d" "$((10#$last + 1))") # crazy padding

echo Adding project \#$lastnum $newfilename

FILENAME="$lastnum-$newfilename"
mkdir $FILENAME

cd "$FILENAME"
touch main.c "$newfilename".asm
cp ../Makefile_Template Makefile
sed -i "1i NAME=$newfilename" Makefile

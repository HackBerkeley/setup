#!/bin/bash

# Creates the basic empty guide structure for a given software/library

if [ -z "$1" ] ; then
    echo "Usage: "
    echo "$0 <name>"
fi


while (("$#")) ; do
    name="$1"
    for os in windows osx linux ; do
        if [ -d $os/$name ] ; then
            echo "$name setup folder for $os already exists! Leaving it alone."
            continue
        fi
        mkdir $os/$name
        echo "#$name setup" > $os/$name/readme.md
    done
    shift
done

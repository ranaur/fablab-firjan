#!/bin/bash
# Fix download names for https://3axis.co/ files. Save the image as TITLE - (random number of the model).jpg and save the original file in the same directory (random number).extension.
#
# This script renames the file to match the image's description.
#
#
for t in *" - "*.* ; do 
    DESC="${t% - *}"
    FILE="${t#* - }"
    NAME="${FILE%.*}"
    if [ -f "$NAME".* ] then OF="$(ls "$NAME".*)"
        EXT="${OF##*.}"
        mv "$NAME".* "$DESC - $NAME".$EXT
        echo $t
    fi
done

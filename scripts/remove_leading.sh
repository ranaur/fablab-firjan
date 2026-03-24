#!/bin/bash
#
#
LEADING_CHAR="!"
for t in "$LEADING_CHAR"* ; do 
    echo Fixing "$t"
    mv "$t" "${t#$LEADING_CHAR}" 
done

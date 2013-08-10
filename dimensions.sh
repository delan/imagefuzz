#!/bin/sh
w=`identify "$1" | cut -d ' ' -f 3 | cut -d x -f 1`
h=`identify "$1" | cut -d ' ' -f 3 | cut -d x -f 2`
printf '%s\t%s' "$w" "$h"

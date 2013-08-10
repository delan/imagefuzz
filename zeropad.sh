#!/bin/sh
current_number="$1"
total_number="$2"
digits=`printf '%s' "$total_number" | wc -c`
printf '%0'"$digits"'s' "$current_number"

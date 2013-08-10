#!/bin/sh
while true; do
	path="/tmp/fuzz-$$$RANDOM$$$RANDOM$$"
	if [ -e "$path" ]; then
		false
	else
		mkdir "$path"
		echo "$path"
		echo "$path" 1>&2
		break
	fi
done

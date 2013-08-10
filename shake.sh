#!/bin/sh

input_file="$1"
total_frames="$2"
max="$3"
min="$4"

D=`./tmpdir.sh`
W=`./dimensions.sh "$input_file" | cut -f 1`
H=`./dimensions.sh "$input_file" | cut -f 2`

for j in `seq "$total_frames"`; do
	j=`./zeropad.sh "$j" "$total_frames"`
	printf '\r%s' "frame $j"
	w=$[W-max]
	h=$[H-max]
	# Random in [-(max-min)/2 .. (max-min)/2]
	x=$[RANDOM%(1+max-min)-(max-min)/2]
	y=$[RANDOM%(1+max-min)-(max-min)/2]
	# Now add (min/2) to the magnitude
	if [ "$x" -lt "0" ]; then
		x=$[x-min/2]
	else
		x=$[x+min/2]
	fi
	if [ "$y" -lt "0" ]; then
		y=$[y-min/2]
	else
		y=$[y+min/2]
	fi
	# Then bring them out of negative
	x=$[x+max/2]
	y=$[y+max/2]
	# Finally, crop
	convert "$input_file" -crop "$w"'x'"$h"'+'"$x"'+'"$y" "$D/$j.jpg"
	i=$j
	echo
done

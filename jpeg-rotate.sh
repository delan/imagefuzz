#!/bin/sh

input_file="$1"
total_frames="$2"
steps_per_frame="$3"
strength="$4"

D=`./tmpdir.sh`
W=`./dimensions.sh "$input_file" | cut -f 1`
H=`./dimensions.sh "$input_file" | cut -f 2`

i=00

convert "$input_file" "$D/$i.jpg"

for j in `seq "$total_frames"`; do
	j=`./zeropad.sh "$j" "$total_frames"`
	convert "$D/$i.jpg" -rotate -"$strength" "$D/$j.jpg"
	for k in `seq "$steps_per_frame"`; do
		k=`./zeropad.sh "$k" "$steps_per_frame"`
		printf '\r%s' "frame $j, step $k"
		convert "$D/$j.jpg" -rotate "$strength" "$D/$j.jpg"
		convert "$D/$j.jpg" -gravity Center \
			-crop "$W"'x'"$H"'+0+0' "$D/$j.jpg"
		convert "$D/$j.jpg" -rotate -"$strength" "$D/$j.jpg"
	done
	convert "$D/$j.jpg" -rotate "$strength" "$D/$j.jpg"
	convert "$D/$j.jpg" -gravity Center -crop "$W"'x'"$H"'+0+0' "$D/$j.jpg"
	i=$j
	echo
done

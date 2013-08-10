#!/bin/sh

D=`./tmpdir.sh`

# Many viewers use artificial delays for frames that are 0/100s or 1/100s long.
convert -delay 2 -loop 0 "$@" "$D/out.gif"

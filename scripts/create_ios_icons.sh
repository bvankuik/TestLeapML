#!/bin/sh -e
#
# Convert an image to the appropriate asset

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 input-png output-directory" >&2
  echo
  echo "input-png        	image that is square and at least 1024x1024" >&2
  echo "output-directory 	Xcode AppIcon folder containing Contents.json" >&2
  echo "                    with the exact filenames that this script uses" >&2
  exit 1
fi

if ! [ -d "$2" ]; then
    echo "Last parameter is not a directory" >&2
    exit 1
fi

if ! which convert > /dev/null; then
    echo "Could not find the convert utility, please install ImageMagick" >&2
    echo "Hint: brew install imagemagick" >&2
    exit 1
fi

orig="$1"
tmpdir=$(mktemp -d)
new_prefix="${tmpdir}/appicon_"

ios="1024"
macos="16 32 128 256 512"

##############################################################################

myconvert() {
    size=$1                         # width (also used for height)
    orig=$2                         # the 1024x1024 original png
    output="${new_prefix}$3.png"   # the new name

    convert -resize "${size}x${size}" "$orig" "${output}"
    echo "Outputting file ${output}"
}

##############################################################################

# For iOS, it's easy
myconvert "${ios}x${ios}" "$orig" "$ios"

# Looping for macOS
for res in $macos; do
    myconvert "$res" "$orig" "$res"
    res2x=$((2*$res))
    myconvert "$res2x" "$orig" "${res}_2x"
done

mv "$tmpdir"/* "$2"

# cleanup
rmdir "$tmpdir"


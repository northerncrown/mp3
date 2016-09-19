#!/bin/bash
#
# 20121117
#
# Make a couple of files for cover art and put one into the mp3 files.
#
# Requirements:  image-magick, eyeD3
#
# https://github.com/northerncrown/mp3


EYED3=/usr/local/bin/eyeD3
CONVERT=/usr/bin/convert
IDENTIFY=/usr/bin/identify

FILE=$1

cp $FILE $FILE.orig

BEFORE=`$IDENTIFY $FILE`

echo "Before: $BEFORE"

$CONVERT $FILE  -thumbnail x1000 -resize 50% -gravity center -crop 500x500+0+0 +repage -format jpg -quality 99   cover.jpg
$CONVERT $FILE  -thumbnail x240 -resize 50% -gravity center -crop 120x120+0+0 +repage -format jpg -quality 99   folder.jpg

cp cover.jpg album.jpg

AFTER=`$IDENTIFY cover.jpg`
echo "After (full-size): $AFTER"
AFTER=`$IDENTIFY folder.jpg`
echo "After (fuze-size): $AFTER"

echo "Inserting folder.jpg into files"

$EYED3 --add-image folder.jpg:FRONT_COVER *mp3

rm $FILE



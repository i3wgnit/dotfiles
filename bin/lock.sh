#!/bin/sh


FOLDER="$HOME/.dotfiles/i3"
LOCK="$FOLDER/lock.png"

#convert /tmp/screen.png -spread 12 -median 3 -paint 2 /tmp/screen.png
#convert /tmp/screen.png  -spread 3 -median 4 /tmp/screen.png
CONVERT_PARAMS="-spread 3 -median 4"

DISPLAY_RE='([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+)'
SDISPLAY_RE='\([0-9]*\)x\([0-9]*\)+\([0-9]*\)+\([0-9]*\)'
IMAGE_RE='([0-9]+)x([0-9]+)'

IMAGE=`mktemp --suffix=.png`

maim $IMAGE -d 0.1 --quiet

if test -f ~/.dotfiles/bin/lock.png; then
    read IMAGE_WIDTH IMAGE_HEIGHT <<EOF
`identify -format '%w %h' -- "$LOCK"`
EOF

    convert "$IMAGE" $CONVERT_PARAMS \
    $( xrandr |\
           grep -E -o "$DISPLAY_RE" |\
           while read LINE
           do
               read WIDTH HEIGHT X Y <<EOF
`echo "$LINE" | sed "s:$SDISPLAY_RE:\\1 \\2 \\3 \\4:"`
EOF

               POS_X=$(($X + $WIDTH / 2 - $IMAGE_WIDTH / 2))
               POS_Y=$(($Y + $HEIGHT /2 - $IMAGE_HEIGHT / 2))

               echo $LOCK
               echo -geometry
               echo "+$POS_X+$POS_Y"
               echo -composite
           done ) \
               "$IMAGE"
else
    convert "$IMAGE" $CONVERT_PARAMS "$IMAGE"
fi


i3lock -fec 000000 -i $IMAGE
rm $IMAGE

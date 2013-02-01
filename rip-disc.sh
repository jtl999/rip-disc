#!/bin/dash

TMPDIR=`mktemp -d`
DESTDIR=`pwd`
TAGGER=`which picard`

TRACK_TEMPLATE='%A - %d (%y) [%x]/%t. %a - %n'
DISC_TEMPLATE='%A - %d (%y) [%x]/%A - %d'

echo "Ripping to $TMPDIR."


echo '... Ripping the CD.'
rip cd rip --logger whatcd --working-directory="$TMPDIR" --output-directory='' \
           --track-template="$TRACK_TEMPLATE" --disc-template="$DISC_TEMPLATE"

echo '... Calculating ReplayGain.'
metaflac --add-replay-gain $TMPDIR/*/*.flac

# echo '... Additionally tag files.'
$TAGGER $TMPDIR/*

# echo '... Generating torrent file.'
# mktor ...

echo "... Moving files to $DESTDIR."
mv -v $TMPDIR/* "$DESTDIR"

echo '... Cleaning up.'
rmdir $TMPDIR

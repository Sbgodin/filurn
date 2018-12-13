#!/bin/sh

. /etc/filurn.conf
# gets $MOUNT $MARKER
echo $MOUNT
SCRIPT_DIR="/usr/local/bin/filurn"
while : 
do 
	if [ -f $MOUNT/$MARKER ] ;then
		inotifywait $MOUNT/$MARKER && $SCRIPT_DIR/filurn.sh
	else
		echo "mounting... $MOUNT/$MARKER not found."
		$SCRIPT_DIR/filurn-mount.sh		
	fi
done

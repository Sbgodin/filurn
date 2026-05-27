#!/bin/sh

. /etc/filurn.conf
# get $MOUNT $DISK $MARKER

NAME="filurn"
MAPPER="/dev/mapper/$NAME"

umount $MAPPER
cryptsetup close $MAPPER

cryptsetup open --type plain --cipher aes-xts-plain64 --key-file /dev/urandom "$DISK" "$NAME"

mkfs.ext2 -L $NAME -m 0 -E root_owner=1000:1000 $MAPPER >/dev/null
mount $MAPPER $MOUNT
rmdir $MOUNT/lost+found
touch $MOUNT/$MARKER

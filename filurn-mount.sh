#!/bin/sh

. /etc/filurn.conf
# get $MOUNT $DISK $MARKER

NAME="filurn"
MAPPER="/dev/mapper/$NAME"

sudo umount $MAPPER
sudo cryptsetup close $MAPPER

sudo cryptsetup open --type plain --cipher aes-xts-plain64 --key-file /dev/urandom "$DISK" "$NAME"

sudo mkfs.ext2 -L $NAME -m 0 -E root_owner=1000:1000 $MAPPER >/dev/null
sudo mount $MAPPER $MOUNT
sudo rmdir $MOUNT/lost+found
sudo touch $MOUNT/$MARKER

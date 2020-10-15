#!/bin/bash

set -u

checkMount() {
    fstype=$(df --output=fstype "$1" | tail -1)

    if [ "${fstype}" != "fuse.s3fs" ]; then
        echo "Expected $1 to be a FUSE S3FS filesystem but found ${fstype}. Attempting to unmount it..."
        umount -l -f "$1"
        echo "Attempting to remount $1..."
        (mount "$1" && echo "Remounted $1") || echo "Unable to mount $1!"
    fi
}

checkMount "/srv/chronam/word_coordinates"
checkMount "/srv/chronam/ocr"
checkMount "/srv/chronam/batches"

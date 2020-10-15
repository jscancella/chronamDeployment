#!/bin/bash

set -e

cd /tmp/s3fs-fuse-1.85
./autogen.sh
./configure --prefix=/usr
make
sudo make install

#! /usr/bin/bash

export CFLAGS="-fPIC -fcommon"
./configure --prefix=$PREFIX

make -j$(nproc)
make install

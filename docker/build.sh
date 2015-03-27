#!/bin/bash
set -e
source /img_build/buildconfig
set -x

# Copy runit files
cp -R /img_build/runit/* /etc/my_init.d/

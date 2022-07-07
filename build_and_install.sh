#!/usr/bin/sh

# Build.
cmake -Bbuild && cd build && make -j16

# Install.
cd *facts/LV2 && sudo cp -r * /usr/lib/lv2

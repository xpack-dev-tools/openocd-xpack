#!/usr/bin/env bash
rm -rf "${HOME}/Downloads/openocd-xpack.git"
git clone --recurse-submodules https://github.com/gnu-mcu-eclipse/openocd-xpack.git "${HOME}/Downloads/openocd-xpack.git"

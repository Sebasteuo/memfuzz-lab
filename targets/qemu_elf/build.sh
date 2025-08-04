#!/usr/bin/env bash
set -eux
cd "$(dirname "$0")"        #  Change the current working directory to targets/qemu_elf
mkdir -p build
# We compile in 32-bit mode, statically, using afl-clang-fast
afl-clang-fast -static -O2 src/mini_png.c -o build/mini_png

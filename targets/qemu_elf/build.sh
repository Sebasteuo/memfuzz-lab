#!/usr/bin/env bash
# memfuzz-lab helper script
# All output and comments are in English.
set -euo pipefail
IFS=$'
	'
set -eux
cd "$(dirname "$0")"        #  Change the current working directory to targets/qemu_elf
mkdir -p build
# We compile in 32-bit mode, statically, using afl-clang-fast
afl-clang-fast -static -O2 src/mini_png.c -o build/mini_png

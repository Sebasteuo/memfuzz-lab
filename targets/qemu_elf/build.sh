#!/usr/bin/env bash
set -eux
cd "$(dirname "$0")"        #  mueve el cwd a targets/qemu_elf
mkdir -p build
# Compilamos en 32 bits, estático, con afl-clang-fast
afl-clang-fast -static -O2 src/mini_png.c -o build/mini_png

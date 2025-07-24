#!/usr/bin/env bash
# Build the PNG parser with AFL instrumentation and AddressSanitizer
set -e
CC=afl-gcc
CFLAGS="-g -O2 -fsanitize=address -fno-omit-frame-pointer"
OUT_DIR="targets/png_parser/build"
mkdir -p "${OUT_DIR}"
${CC} ${CFLAGS} targets/png_parser/src/pngparse.c -o "${OUT_DIR}/pngparse"


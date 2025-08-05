#!/usr/bin/env bash
set -e
CC=${CC:-afl-clang-fast++}          # tinyxml2 es C++
CXX=${CC}
CFLAGS="-g -O2 -fsanitize=address -fno-omit-frame-pointer"
LDFLAGS="-fsanitize=address"

SRC_DIR="$(dirname "$0")/src"
BUILD_DIR="$(dirname "$0")/build"
mkdir -p "$BUILD_DIR"

# Compila la librería y el binario de prueba 'xmltest'
cd "$SRC_DIR"
${CXX} ${CFLAGS} tinyxml2.cpp xmltest.cpp -o "$BUILD_DIR/xmltest" ${LDFLAGS}

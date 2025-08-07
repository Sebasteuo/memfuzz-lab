#!/usr/bin/env bash
set -e
CC=${CC:-afl-clang-fast++}
CXX=${CC}
CFLAGS="-g -O2 -fsanitize=address -fno-omit-frame-pointer"
LDFLAGS="-fsanitize=address"

SRC_DIR="$(dirname "$0")/src"
BUILD_DIR="$(dirname "$0")/build"
mkdir -p "$BUILD_DIR"

cd "$SRC_DIR"
${CXX} ${CFLAGS} tinyxml2.cpp xmltest.cpp -o "$BUILD_DIR/xmltest" ${LDFLAGS}

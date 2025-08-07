#!/usr/bin/env bash
set -e

# ── compilador con AFL++ (C++) ───────────────────────────────────────────────
CC=${CC:-afl-clang-fast++}
CXX=${CC}
CFLAGS="-g -O2 -fsanitize=address -fno-omit-frame-pointer"
LDFLAGS="-fsanitize=address"

# ── rutas absolutas ─────────────────────────────────────────────────────────
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="$BASE_DIR/src"
BUILD_DIR="$BASE_DIR/build"

mkdir -p "$BUILD_DIR"
cd "$SRC_DIR"

# ── compilar xmltest con la librería estática ───────────────────────────────
$CXX $CFLAGS tinyxml2.cpp xmltest.cpp -o "$BUILD_DIR/xmltest" $LDFLAGS

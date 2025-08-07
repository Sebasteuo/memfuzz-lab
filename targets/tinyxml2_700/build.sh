#!/usr/bin/env bash
set -euo pipefail

# ── compilador (AFL++) ───────────────────────────────────────────────────────
CXX=${CXX:-afl-clang-fast++}
CFLAGS="-g -O2 -std=c++11 -fsanitize=address -fno-omit-frame-pointer"
LDFLAGS="-fsanitize=address"

# ── rutas ────────────────────────────────────────────────────────────────────
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="$BASE_DIR/src"
BUILD_DIR="$BASE_DIR/build"

mkdir -p "$BUILD_DIR"
cd "$SRC_DIR"

# ── compilar ────────────────────────────────────────────────────────────────
$CXX $CFLAGS tinyxml2.cpp xmltest.cpp -o "$BUILD_DIR/xmltest" $LDFLAGS

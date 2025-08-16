#!/usr/bin/env bash
# memfuzz-lab helper script
# All output and comments are in English.
set -euo pipefail
IFS=$'
	'
export CC=afl-clang-fast
export CXX=afl-clang-fast++
#!/usr/bin/env bash
# Build the PNG parser with AFL instrumentation and AddressSanitizer
set -e
CC=afl-clang-fast
CFLAGS="-g -O2 -fsanitize=address -fno-omit-frame-pointer"
OUT_DIR="targets/png_parser/build"
mkdir -p "${OUT_DIR}"
${CC} ${CFLAGS} targets/png_parser/src/pngparse.c -o "${OUT_DIR}/pngparse" -lpng -lz


# MemFuzz-Lab

MemFuzz-Lab is an automated security playground that combines greybox fuzzing (AFL++) with full memory forensics (Volatility 3) inside a reproducible QEMU environment.  
The CI pipeline builds instrumented targets, explores millions of paths, captures crashes, extracts core dumps and produces enriched reports, so researchers can understand *why* a vulnerability occurs, not just *that* it occurs.

## Quick start
```bash
docker build -t memfuzz-lab:latest docker/
bash targets/png_parser/build.sh
timeout 15m afl-fuzz -i targets/png_parser/corpus -o out -- \
  targets/png_parser/build/pngparse @@


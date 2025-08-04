# MemFuzz-Lab

MemFuzz-Lab is an automated security playground that combines greybox fuzzing (AFL++) with full memory forensics (Volatility 3) inside a reproducible QEMU environment.  
The CI pipeline builds instrumented targets, explores millions of paths, captures crashes, extracts core dumps and produces enriched reports, so researchers can understand *why* a vulnerability occurs, not just *that* it occurs.

**MemFuzz‑Lab** is a minimal CI pipeline that:

1. Builds a target binary with ASan instrumentation.
2. Runs AFL++ on every push.
3. Packages crashes as CI artefacts.
4. Symbolises the stack‑trace and automatically opens a GitHub Issue.

## How it works
* `fuzz.yml` – GitHub Actions workflow.
* `scripts/symbolize_and_issue.sh` – converts ASan traces into Issues.
* `targets/png_parser` – tiny demo target.

## Try it yourself
```bash
# 1) Trigger manually
gh workflow run "Fuzzing Pipeline" --ref main

# 2) Introduce a crash (e.g. write to address 0) in a feature branch
# 3) Push → CI opens an Issue with the trace


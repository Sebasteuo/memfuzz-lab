#!/usr/bin/env bash
# memfuzz-lab helper script
# All output and comments are in English.
set -euo pipefail
export PATH="$PATH:/usr/local/bin"

TAR="crashes-png_parser.tar.gz"
REPO="${GITHUB_REPOSITORY:-""}"      # empty locally

# ── exit if no tar file is present ──────────────────────────────────────────────────────
[ -f "$TAR" ] || { echo "🟡  No crashes found, exiting"; exit 0; }

mkdir -p work
tar -xzf "$TAR" -C work

BIN=$(find ./targets/png_parser/build -type f -perm -111 | head -1)
[ -x "$BIN" ] || { echo "🛑 Binary not found"; exit 1; }

for f in work/crashes/id:*; do
  base=$(basename "$f")
  out="${base}.txt"

  ASAN_SYMBOLIZER_PATH=$(command -v llvm-symbolizer) \
  ASAN_OPTIONS=symbolize=1:detect_leaks=0 \
  "$BIN" "$f" 2>&1 | tee "$out" >/dev/null || true

  summary=$(grep -m1 -v '^$' "$out" | cut -c1-120)
  [ -z "$summary" ] && summary="ASAN SEGV crash"
  title="Crash: $summary [$(date +%F-%H%M)]"

  if [[ -n "$REPO" ]]; then
    gh issue create \
      --repo "$REPO" \
      --title "$title" \
      --body "$(printf '### 💥 Fuzzing crash detected\n\n**Input**: `%s`\n\n```\n%s\n```' "$base" "$(cat "$out")")" \
      || true
  else
    echo -e "\n–––––\n$title\n$(cat "$out")\n–––––"
  fi
done

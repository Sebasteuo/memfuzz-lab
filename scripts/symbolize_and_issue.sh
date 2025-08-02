#!/usr/bin/env bash
set -euo pipefail
export PATH="$PATH:/usr/local/bin"

TAR="crashes-png_parser.tar.gz"
REPO="${GITHUB_REPOSITORY:-""}"      # vacío en local

# ── salir si no hay tar ──────────────────────────────────────────────────────
[ -f "$TAR" ] || { echo "🟡  No hay crashes, salgo"; exit 0; }

mkdir -p work
tar -xzf "$TAR" -C work

BIN=$(find ./targets/png_parser/build -type f -perm -111 | head -1)
[ -x "$BIN" ] || { echo "🛑 Binario no encontrado"; exit 1; }

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

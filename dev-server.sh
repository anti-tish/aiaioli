#!/usr/bin/env bash
# aiaioli live-preview server — same Dart Sass setup as build.sh, but `hugo server` with
# live reload instead of a one-shot build. Edit any content/layout/CSS file and the browser
# repaints in the real site design. Drafts render too (-D). Not for deploy; local preview only.
set -euo pipefail
cd "$(dirname "$0")"

SASS_BIN="$(ls node_modules/sass-embedded-*/dart-sass/sass 2>/dev/null | head -1 || true)"
if [ -n "$SASS_BIN" ]; then
  export PATH="$PWD/$(dirname "$SASS_BIN"):$PATH"
fi

exec hugo server -D --disableFastRender --bind 0.0.0.0 --port 1313

#!/usr/bin/env bash
# aiaioli build — texify3 needs Dart Sass. The sass-embedded npm package ships a native
# binary in a platform subpackage (darwin-arm64 locally, linux-x64 on Cloudflare); Hugo only
# finds Dart Sass on PATH, so locate the right one and add it. Cloudflare runs `npm install`
# first, then this. Build command on Cloudflare Pages: `bash build.sh` (root dir: aiaioli-hugo).
set -euo pipefail

SASS_BIN="$(ls node_modules/sass-embedded-*/dart-sass/sass 2>/dev/null | head -1 || true)"
if [ -n "$SASS_BIN" ]; then
  export PATH="$PWD/$(dirname "$SASS_BIN"):$PATH"
  echo "dart-sass on PATH: $(dirname "$SASS_BIN")"
else
  echo "WARN: native dart-sass not found under node_modules/sass-embedded-*; build may fail on SCSS."
fi

hugo --gc --minify

#!/bin/sh
# Start the dev server (uses project .node if npm not in PATH)
ROOT="$(cd "$(dirname "$0")" && pwd)"
export PATH="${ROOT}/.node/root/bin:${PATH}"
cd "$ROOT" && npm run dev

#!/usr/bin/env bash
# 也可直接用根目錄 Makefile: make sim
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "${ROOT}"
make sim "$@"

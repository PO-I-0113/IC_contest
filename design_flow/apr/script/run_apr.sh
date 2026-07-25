#!/usr/bin/env bash
# APR 啟動模板（ICC2 或 Innovus，擇一啟用）
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TOP="${TOP:-DESIGN_TOP}"

echo "[APR] TOP=${TOP}"
echo "[APR] 請依工具選擇取消下方註解"

# --- Synopsys ICC2 範例 ---
# icc2_shell -f "${ROOT}/apr/script/run_icc2.tcl" | tee "${ROOT}/apr/report/apr.log"

# --- Cadence Innovus 範例 ---
# innovus -file "${ROOT}/apr/script/run_innovus.tcl" | tee "${ROOT}/apr/report/apr.log"

echo "[APR] script template only — no tool invoked"

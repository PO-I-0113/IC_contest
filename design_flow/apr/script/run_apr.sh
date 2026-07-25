#!/usr/bin/env bash
# 在 apr/script 下執行；實際路徑切換交给 run_innovus.tcl
set -euo pipefail

TOP="${TOP:-DESIGN_TOP}"
echo "[APR] Innovus flow, TOP=${TOP}"

innovus -file run_innovus.tcl -log ../report/innovus.log -overwrite

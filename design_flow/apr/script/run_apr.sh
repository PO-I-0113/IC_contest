#!/usr/bin/env bash
# 在 apr/script 下執行；環境變數傳入 TOP/TECH/CLK/SCAN
set -euo pipefail

TOP="${TOP:-DESIGN_TOP}"
TECH="${TECH:-U18}"
CLK="${CLK:-10}"
SCAN="${SCAN:-0}"

echo "[APR] Innovus  TOP=${TOP} TECH=${TECH} CLK=${CLK} SCAN=${SCAN}"

# log 目錄由 tcl 依 SCAN 建立；此處先放暫存
mkdir -p "../report/clk_${CLK}"
export TOP TECH CLK SCAN
innovus -file run_innovus.tcl -log "../report/clk_${CLK}/innovus_scan${SCAN}.log" -overwrite

#!/usr/bin/env bash
set -euo pipefail

TOP="${TOP:-DESIGN_TOP}"
TECH="${TECH:-U18}"
CLK="${CLK:-10}"
NET_TAG="${NET_TAG:-syn}"

echo "[APR] Innovus  TOP=${TOP} TECH=${TECH} CLK=${CLK} NET_TAG=${NET_TAG}"

mkdir -p "../report/clk_${CLK}/${NET_TAG}"
export TOP TECH CLK NET_TAG
innovus -file run_innovus.tcl -log "../report/clk_${CLK}/${NET_TAG}/innovus.log" -overwrite

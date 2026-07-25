#!/usr/bin/env bash
# Code Coverage（相對 design_flow/ 路徑）
# 執行：cd cov/script && bash run_cov.sh [TOP] [vcs|xrun]
set -euo pipefail

TOP="${1:-DESIGN_TOP}"
SIM="${2:-vcs}"

# 切回 design_flow/
cd ../..
mkdir -p cov/report work/cov

echo "[COV] TOP=${TOP} SIM=${SIM} cwd=$(pwd)"

if [[ "${SIM}" == "vcs" ]]; then
  # 相對路徑範例（需要時取消註解）
  # cd work/cov
  # vcs -full64 -sverilog -cm line+tgl+fsm+cond \
  #   -f ../../rtl/filelist.f ../../sim/tb/tb_${TOP}.sv -o simv
  # ./simv -cm line+tgl+fsm+cond
  # urg -dir simv.vdb -report ../../cov/report
  echo "[COV] VCS coverage 指令尚未啟用，請依環境取消註解（保持相對路徑）"
else
  # xrun -sv -coverage all -f rtl/filelist.f sim/tb/tb_${TOP}.sv
  echo "[COV] xrun coverage 指令尚未啟用，請依環境取消註解（保持相對路徑）"
fi

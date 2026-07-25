#!/usr/bin/env bash
# Code Coverage 執行模板（VCS urg / xrun imc 請依環境調整）
set -euo pipefail

TOP="${1:-DESIGN_TOP}"
SIM="${2:-vcs}"
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT_DIR="${ROOT}/cov/report"
mkdir -p "${OUT_DIR}"

echo "[COV] TOP=${TOP} SIM=${SIM}"
echo "[COV] 請依工作站實際指令修改此腳本"

if [[ "${SIM}" == "vcs" ]]; then
  # 範例：先以 coverage option 編譯並執行，再 urg 產報告
  # cd "${ROOT}/work/cov" && \
  # vcs -full64 -sverilog -cm line+tgl+fsm+cond \
  #   -f "${ROOT}/rtl/filelist.f" "${ROOT}/sim/tb/tb_${TOP}.sv" -o simv && \
  # ./simv -cm line+tgl+fsm+cond && \
  # urg -dir simv.vdb -report "${OUT_DIR}"
  echo "[COV] VCS coverage 指令尚未啟用，請取消註解並設定路徑"
else
  # xrun -sv -coverage all -f ... 
  echo "[COV] xrun coverage 指令尚未啟用，請取消註解並設定路徑"
fi

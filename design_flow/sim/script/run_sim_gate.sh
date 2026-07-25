#!/usr/bin/env bash
# ============================================================
# Gate-level 模擬（相對 design_flow/ 路徑）
# 執行：make sim_gate CLK=10 SCAN=0
#       make sim_gate CLK=10 SCAN=1
# GATE_NET 可覆寫：auto|syn|dft（預設依 SCAN）
# ============================================================
set -euo pipefail

# 切回 design_flow/
cd "$(dirname "$0")/../.."

TOP="${TOP:-DESIGN_TOP}"
TECH="${TECH:-U18}"
CLK="${CLK:-10}"
SCAN="${SCAN:-0}"
SIM="${SIM:-vcs}"
GATE_NET="${GATE_NET:-}"       # 空 = 跟 SCAN；也可 syn|dft|auto
TIMING="${TIMING:-1}"          # 1=做 timing check；0=+notimingcheck

CLK_TAG="clk_${CLK}"
NET_DIR="syn/netlist/${CLK_TAG}"
RPT_DIR="syn/report/${CLK_TAG}"
TB_FILE="${TB_FILE:-sim/tb/tb_${TOP}.sv}"
TECH_VERILOG="${TECH_VERILOG:-lib/${TECH}/stdcell/typical.v}"

NET_SYN="${NET_DIR}/${TOP}_syn.v"
NET_DFT="${NET_DIR}/${TOP}_syn_dft.v"
SDF_SYN="${RPT_DIR}/${TOP}_syn.sdf"
SDF_DFT="${RPT_DIR}/${TOP}_syn_dft.sdf"

# SCAN → 預設選網表；GATE_NET 可覆寫
if [[ -z "${GATE_NET}" ]]; then
  if [[ "${SCAN}" == "1" ]]; then GATE_NET="dft"; else GATE_NET="syn"; fi
fi

NET_TAG="syn"
[[ "${GATE_NET}" == "dft" || ( "${GATE_NET}" == "auto" && -f "${NET_DFT}" ) ]] && NET_TAG="dft"
SIM_RPT="sim/report/${CLK_TAG}/${NET_TAG}"
WORK_DIR="work/sim_gate/${CLK_TAG}/${NET_TAG}"
mkdir -p "${SIM_RPT}" "${WORK_DIR}"

pick_net() {
  case "${GATE_NET}" in
    syn)
      NETLIST="${NET_SYN}"; SDF_FILE="${SDF_SYN}"; NET_TAG="syn" ;;
    dft)
      NETLIST="${NET_DFT}"; SDF_FILE="${SDF_DFT}"; NET_TAG="dft" ;;
    auto)
      if [[ -f "${NET_DFT}" ]]; then
        NETLIST="${NET_DFT}"; SDF_FILE="${SDF_DFT}"; NET_TAG="dft"
        echo "[sim_gate] GATE_NET=auto → DFT netlist"
      else
        NETLIST="${NET_SYN}"; SDF_FILE="${SDF_SYN}"; NET_TAG="syn"
        echo "[sim_gate] GATE_NET=auto → syn netlist"
      fi
      ;;
    *)
      echo "[ERROR] GATE_NET 僅支援 auto|syn|dft"; exit 1 ;;
  esac
}

pick_net
SIM_RPT="sim/report/${CLK_TAG}/${NET_TAG}"
WORK_DIR="work/sim_gate/${CLK_TAG}/${NET_TAG}"
mkdir -p "${SIM_RPT}" "${WORK_DIR}"

echo "[sim_gate] TOP=${TOP} TECH=${TECH} CLK=${CLK} SCAN=${SCAN} GATE_NET=${GATE_NET}"
echo "[sim_gate] NETLIST=${NETLIST}"
echo "[sim_gate] SDF=${SDF_FILE}"
echo "[sim_gate] TECH_VERILOG=${TECH_VERILOG}"

if [[ ! -f "${NETLIST}" ]]; then
  echo "[ERROR] 找不到 gate netlist: ${NETLIST}"
  echo "        請先: make syn CLK=${CLK} 或 make syn_dft CLK=${CLK}"
  exit 1
fi
if [[ ! -f "${TECH_VERILOG}" ]]; then
  echo "[ERROR] 找不到製程 verilog model: ${TECH_VERILOG}"
  echo "        請放到 lib/${TECH}/stdcell/ 或指定 TECH_VERILOG=..."
  exit 1
fi
if [[ ! -f "${TB_FILE}" ]]; then
  echo "[ERROR] 找不到 testbench: ${TB_FILE}"
  exit 1
fi

# SDF 可選：沒有仍可跑功能 gate sim（建議有）
SDF_DEFINE="+define+SDF"
if [[ -f "${SDF_FILE}" ]]; then
  # 傳給 TB 的字串巨集（相對 design_flow/）
  SDF_DEFINE+="+define+SDF_FILE=\"${SDF_FILE}\""
  echo "[sim_gate] 啟用 SDF annotate"
else
  echo "[WARN] 找不到 SDF: ${SDF_FILE}，改跑無 SDF gate sim"
  SDF_DEFINE="+define+SDF"
fi

TIMING_FLAG=""
if [[ "${TIMING}" == "0" ]]; then
  TIMING_FLAG="+notimingcheck"
  echo "[sim_gate] TIMING=0 → +notimingcheck"
fi

LOG="${SIM_RPT}/sim_gate_${GATE_NET}.log"

run_vcs() {
  local out="${WORK_DIR}/simv_gate"
  # shellcheck disable=SC2086
  vcs -full64 -sverilog -debug_access+all \
    +access+r +neg_tchk \
    ${TIMING_FLAG} \
    ${SDF_DEFINE} \
    "${TB_FILE}" "${NETLIST}" "${TECH_VERILOG}" \
    -o "${out}"
  "${out}" 2>&1 | tee "${LOG}"
}

run_xrun() {
  # shellcheck disable=SC2086
  xrun -sv +access+r \
    ${TIMING_FLAG} \
    ${SDF_DEFINE} \
    "${TB_FILE}" "${NETLIST}" "${TECH_VERILOG}" \
    2>&1 | tee "${LOG}"
}

run_nc() {
  # shellcheck disable=SC2086
  ncverilog -sv +access+r \
    ${TIMING_FLAG} \
    ${SDF_DEFINE} \
    "${TB_FILE}" "${NETLIST}" "${TECH_VERILOG}" \
    2>&1 | tee "${LOG}"
}

case "${SIM}" in
  vcs) run_vcs ;;
  xrun) run_xrun ;;
  ncverilog) run_nc ;;
  *) echo "[ERROR] 不支援 SIM=${SIM}（vcs|xrun|ncverilog）"; exit 1 ;;
esac

echo "[sim_gate] log → ${LOG}"

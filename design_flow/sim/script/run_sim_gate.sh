#!/usr/bin/env bash
# ============================================================
# Gate-level 模擬
#   make sim_gate      → NET_TAG=syn
#   make sim_gate_dft  → NET_TAG=dft
# ============================================================
set -euo pipefail

cd "$(dirname "$0")/../.."

TOP="${TOP:-DESIGN_TOP}"
TECH="${TECH:-U18}"
CLK="${CLK:-10}"
NET_TAG="${NET_TAG:-syn}"
SIM="${SIM:-vcs}"
TIMING="${TIMING:-1}"

if [[ "${NET_TAG}" != "dft" ]]; then NET_TAG="syn"; fi

CLK_TAG="clk_${CLK}"
NET_DIR="syn/netlist/${CLK_TAG}"
RPT_DIR="syn/report/${CLK_TAG}"
SIM_RPT="sim/report/${CLK_TAG}/${NET_TAG}"
WORK_DIR="work/sim_gate/${CLK_TAG}/${NET_TAG}"
TB_FILE="${TB_FILE:-sim/tb/tb_${TOP}.sv}"
TECH_VERILOG="${TECH_VERILOG:-lib/${TECH}/stdcell/typical.v}"

mkdir -p "${SIM_RPT}" "${WORK_DIR}"

if [[ "${NET_TAG}" == "dft" ]]; then
  NETLIST="${NET_DIR}/${TOP}_syn_dft.v"
  SDF_FILE="${RPT_DIR}/${TOP}_syn_dft.sdf"
else
  NETLIST="${NET_DIR}/${TOP}_syn.v"
  SDF_FILE="${RPT_DIR}/${TOP}_syn.sdf"
fi

echo "[sim_gate] TOP=${TOP} TECH=${TECH} CLK=${CLK} NET_TAG=${NET_TAG}"
echo "[sim_gate] NETLIST=${NETLIST}"
echo "[sim_gate] SDF=${SDF_FILE}"

if [[ ! -f "${NETLIST}" ]]; then
  echo "[ERROR] 找不到 gate netlist: ${NETLIST}"
  if [[ "${NET_TAG}" == "dft" ]]; then
    echo "        請先: make syn_dft CLK=${CLK}"
  else
    echo "        請先: make syn CLK=${CLK}"
  fi
  exit 1
fi
if [[ ! -f "${TECH_VERILOG}" ]]; then
  echo "[ERROR] 找不到製程 verilog model: ${TECH_VERILOG}"
  exit 1
fi
if [[ ! -f "${TB_FILE}" ]]; then
  echo "[ERROR] 找不到 testbench: ${TB_FILE}"
  exit 1
fi

SDF_DEFINE="+define+SDF"
if [[ -f "${SDF_FILE}" ]]; then
  SDF_DEFINE+="+define+SDF_FILE=\"${SDF_FILE}\""
  echo "[sim_gate] 啟用 SDF annotate"
else
  echo "[WARN] 找不到 SDF: ${SDF_FILE}，改跑無 SDF gate sim"
fi

TIMING_FLAG=""
if [[ "${TIMING}" == "0" ]]; then
  TIMING_FLAG="+notimingcheck"
fi

LOG="${SIM_RPT}/sim_gate.log"

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
  *) echo "[ERROR] 不支援 SIM=${SIM}"; exit 1 ;;
esac

echo "[sim_gate] log → ${LOG}"

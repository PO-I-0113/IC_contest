# ============================================================
# TN16 — Formality setup
# TSMC N16 / 16nm 類（依貴單位實際 library 調整）
# 路徑相對 design_flow/
# ============================================================

puts "INFO: Load Formality setup for TECH=TN16"

set TECH_DIR "lib/TN16"
set TECH_STDCELL "${TECH_DIR}/stdcell"

# 若 LEC 需要 technology library，在此補充：
# read_db ${TECH_STDCELL}/slow.db

puts "INFO: TECH_STDCELL = $TECH_STDCELL"

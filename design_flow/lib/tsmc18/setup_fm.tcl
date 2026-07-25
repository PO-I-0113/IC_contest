# ============================================================
# TSMC 180nm 範例 — Formality setup
# 路徑相對 design_flow/
# 若 LEC 需要讀 technology library，在此補充
# ============================================================

puts "INFO: Load Formality setup for TECH=tsmc18"

set TECH_DIR "lib/tsmc18"
set TECH_STDCELL "${TECH_DIR}/stdcell"

# 範例（依 Formality 版本調整）：
# read_db ${TECH_STDCELL}/slow.db
# set_app_var search_path ". ${TECH_STDCELL}"

puts "INFO: TECH_STDCELL = $TECH_STDCELL"

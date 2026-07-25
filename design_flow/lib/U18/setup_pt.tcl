# ============================================================
# U18 — PrimeTime setup
# UMC 180nm 類製程（依貴單位實際 library 調整）
# 路徑相對 design_flow/
# ============================================================

puts "INFO: Load PT setup for TECH=U18"

set TECH_DIR "lib/U18"
set TECH_STDCELL "${TECH_DIR}/stdcell"
set LINK_LIB_FILE "${TECH_STDCELL}/slow.db"

set_app_var search_path ". ${TECH_STDCELL}"
set_app_var link_path   "* $LINK_LIB_FILE"

puts "INFO: link_path lib = $LINK_LIB_FILE"

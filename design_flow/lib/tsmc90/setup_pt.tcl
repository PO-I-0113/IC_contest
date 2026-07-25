# ============================================================
# TSMC 90nm 範例 — PrimeTime setup
# ============================================================

puts "INFO: Load PT setup for TECH=tsmc90"

set TECH_DIR "lib/tsmc90"
set TECH_STDCELL "${TECH_DIR}/stdcell"
set LINK_LIB_FILE "${TECH_STDCELL}/slow.db"

set_app_var search_path ". ${TECH_STDCELL}"
set_app_var link_path   "* $LINK_LIB_FILE"

puts "INFO: link_path lib = $LINK_LIB_FILE"

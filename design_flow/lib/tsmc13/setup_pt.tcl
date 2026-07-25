# ============================================================
# TSMC 130nm 範例 — PrimeTime setup
# ============================================================

puts "INFO: Load PT setup for TECH=tsmc13"

set TECH_DIR "lib/tsmc13"
set TECH_STDCELL "${TECH_DIR}/stdcell"
set LINK_LIB_FILE "${TECH_STDCELL}/slow.db"

set_app_var search_path ". ${TECH_STDCELL}"
set_app_var link_path   "* $LINK_LIB_FILE"

puts "INFO: link_path lib = $LINK_LIB_FILE"

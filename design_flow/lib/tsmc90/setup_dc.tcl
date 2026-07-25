# ============================================================
# TSMC 90nm 範例 — Design Compiler setup
# 路徑相對 design_flow/
# ============================================================

puts "INFO: Load DC setup for TECH=tsmc90"

set TECH_DIR "lib/tsmc90"
set TECH_STDCELL "${TECH_DIR}/stdcell"

set TARGET_LIB_FILE "${TECH_STDCELL}/slow.db"
set LINK_LIB_FILE   "${TECH_STDCELL}/slow.db"

set_app_var search_path  ". rtl/include rtl/src ${TECH_STDCELL}"
set_app_var target_library "$TARGET_LIB_FILE"
set_app_var link_library   "* $LINK_LIB_FILE"

puts "INFO: target_library = $TARGET_LIB_FILE"

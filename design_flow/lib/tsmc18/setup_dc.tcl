# ============================================================
# TSMC 180nm 範例 — Design Compiler setup
# 路徑相對 design_flow/
# 請把該製程 .db / .sdb 放到 lib/tsmc18/stdcell/（或改下方檔名）
# ============================================================

puts "INFO: Load DC setup for TECH=tsmc18"

set TECH_DIR "lib/tsmc18"
set TECH_STDCELL "${TECH_DIR}/stdcell"

# 依你實際放入的檔名修改
set TARGET_LIB_FILE "${TECH_STDCELL}/slow.db"
set LINK_LIB_FILE   "${TECH_STDCELL}/slow.db"
# set SYMBOL_LIB_FILE "${TECH_STDCELL}/slow.sdb"

set_app_var search_path  ". rtl/include rtl/src ${TECH_STDCELL}"
set_app_var target_library "$TARGET_LIB_FILE"
set_app_var link_library   "* $LINK_LIB_FILE"
# set_app_var symbol_library "$SYMBOL_LIB_FILE"

# 可選：wire load（依 library 支援情況調整）
# set_wire_load_mode top
# set_wire_load_model -name "tsmc18_wl10" -library <libname>

puts "INFO: target_library = $TARGET_LIB_FILE"

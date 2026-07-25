# ============================================================
# TN7 — Design Compiler setup
# TSMC N7 / 7nm 類（依貴單位實際 library 調整）
# 路徑相對 design_flow/
# 請把該製程 .db / .sdb 放到 lib/TN7/stdcell/
# ============================================================

puts "INFO: Load DC setup for TECH=TN7"

set TECH_DIR "lib/TN7"
set TECH_STDCELL "${TECH_DIR}/stdcell"

# 依你實際放入的檔名修改
set TARGET_LIB_FILE "${TECH_STDCELL}/slow.db"
set LINK_LIB_FILE   "${TECH_STDCELL}/slow.db"
# set SYMBOL_LIB_FILE "${TECH_STDCELL}/slow.sdb"

set_app_var search_path  ". rtl/include rtl/src ${TECH_STDCELL}"
set_app_var target_library "$TARGET_LIB_FILE"
set_app_var link_library   "* $LINK_LIB_FILE"
# set_app_var symbol_library "$SYMBOL_LIB_FILE"

# 可選：wire load / dont_use 等製程相關設定
# set_wire_load_mode top

puts "INFO: target_library = $TARGET_LIB_FILE"

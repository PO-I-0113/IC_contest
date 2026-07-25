# ============================================================
# 依 TECH 載入製程 setup（嚴格相對路徑）
# ------------------------------------------------------------
# 使用前提：已 cd 到 design_flow/，且已 source common/scripts/setup.tcl
#
# 必要變數：
#   TECH      - 製程名，對應 lib/<TECH>/
#   TECH_TOOL - dc | pt | fm
#
# 範例：
#   set TECH "tsmc18"
#   set TECH_TOOL "dc"
#   source common/scripts/load_tech.tcl
# ============================================================

if {![info exists TECH]} {
    set TECH "tsmc18"
}
if {![info exists TECH_TOOL]} {
    set TECH_TOOL "dc"
}

set TECH_DIR   "lib/${TECH}"
set TECH_SETUP "${TECH_DIR}/setup_${TECH_TOOL}.tcl"

if {![file isdirectory $TECH_DIR]} {
    puts "ERROR: 找不到製程目錄: $TECH_DIR"
    puts "ERROR: 請建立 lib/<TECH>/ 並放入 setup_${TECH_TOOL}.tcl"
    exit 1
}
if {![file exists $TECH_SETUP]} {
    puts "ERROR: 找不到製程 setup: $TECH_SETUP"
    puts "ERROR: 可用製程目錄請查看 lib/"
    exit 1
}

puts "INFO: \[load_tech\] TECH=$TECH  TOOL=$TECH_TOOL"
puts "INFO: \[load_tech\] source $TECH_SETUP"
source $TECH_SETUP

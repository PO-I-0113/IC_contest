# ============================================================
# 共用路徑設定（嚴格相對路徑）
# ------------------------------------------------------------
# 使用前提：
#   1. 由各階段 script 呼叫（Makefile 會先 cd 到 <stage>/script）
#   2. 呼叫端已執行：cd ../..
#      使目前工作目錄 = design_flow/
#   3. 再 source：source common/scripts/setup.tcl
#   4. 需要 library 時再：
#        set TECH_TOOL dc|pt|fm
#        source common/scripts/load_tech.tcl
#
# 製程選擇：TECH（預設 U18），對應 lib/<TECH>/setup_*.tcl
# 可用：U18 / TSMC13 / ADFP / TN16 / TN7
# ============================================================

if {![info exists TOP]} {
    set TOP "DESIGN_TOP"
}
if {![info exists TECH]} {
    set TECH "U18"
}

# ---------- RTL / SIM ----------
set RTL_DIR     "rtl/src"
set INC_DIR     "rtl/include"
set FILELIST    "rtl/filelist.f"
set TB_DIR      "sim/tb"

# ---------- SpyGlass ----------
set SG_SCRIPT   "spyglass/script"
set SG_POLICY   "spyglass/policy"
set SG_WAIVER   "spyglass/waiver"
set SG_REPORT   "spyglass/report"

# ---------- SYN（DC 產出，供後段串接）----------
set SYN_SCRIPT  "syn/script"
set SYN_SDC     "syn/constraint/${TOP}.sdc"
set SYN_NETLIST "syn/netlist/${TOP}_syn.v"
set SYN_SDC_OUT "syn/netlist/${TOP}_syn.sdc"
set SYN_DDC     "syn/netlist/${TOP}_syn.ddc"
set SYN_REPORT  "syn/report"

# ---------- LEC ----------
set LEC_REPORT  "lec/report"
set LEC_SESSION "lec/session/${TOP}_lec.fss"

# ---------- TMAX ----------
set TMAX_REPORT  "tmax/report"
set TMAX_PATTERN "tmax/pattern/${TOP}_atpg.v"

# ---------- PrimeTime ----------
set PT_SCRIPT   "primetime/script"
set PT_SDC      "primetime/constraint/${TOP}.sdc"
set PT_SPEF     "primetime/spef/${TOP}.spef"
set PT_REPORT   "primetime/report"

# ---------- APR (Innovus) ----------
set APR_SCRIPT  "apr/script"
set APR_LIB     "apr/lib"
set APR_LEF     "apr/lef"
set APR_DEF     "apr/def/${TOP}.def"
set APR_GDS     "apr/gds/${TOP}.gds"
set APR_REPORT  "apr/report"

# ---------- 製程目錄（library 設定由 load_tech.tcl 載入）----------
set TECH_DIR     "lib/${TECH}"
set LIB_MEMORY   "lib/memory"
set LIB_TECH     "lib/tech"

puts "INFO: \[setup.tcl\] TOP=$TOP  TECH=$TECH  (cwd=[pwd])"
puts "INFO: \[setup.tcl\] TECH_DIR=$TECH_DIR"
puts "INFO: \[setup.tcl\] SYN_NETLIST=$SYN_NETLIST"

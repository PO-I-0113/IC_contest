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
# 製程選擇：TECH（預設 U18）→ lib/<TECH>/setup_*.tcl
# Clock 分層：CLK（預設 10）→ syn/netlist|report|dft_report/clk_<CLK>/
# ============================================================

# 優先使用 -x 傳入的變數；否則讀環境變數；再否則用預設
if {![info exists TOP]} {
    if {[info exists ::env(TOP)]} { set TOP $::env(TOP) } else { set TOP "DESIGN_TOP" }
}
if {![info exists TECH]} {
    if {[info exists ::env(TECH)]} { set TECH $::env(TECH) } else { set TECH "U18" }
}
if {![info exists CLK]} {
    if {[info exists ::env(CLK)]} { set CLK $::env(CLK) } else { set CLK "10" }
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

# ---------- SYN：依 CLK 分層（clk_<數字>）----------
set CLK_TAG        "clk_${CLK}"
set SYN_SCRIPT     "syn/script"
set SYN_NET_DIR    "syn/netlist/${CLK_TAG}"
set SYN_REPORT     "syn/report/${CLK_TAG}"
set SYN_DFT_REPORT "syn/dft_report/${CLK_TAG}"

# SDC：優先 ${TOP}_clk${CLK}.sdc，否則 ${TOP}.sdc
set SYN_SDC_CLK "syn/constraint/${TOP}_clk${CLK}.sdc"
set SYN_SDC_DEF "syn/constraint/${TOP}.sdc"
if {[file exists $SYN_SDC_CLK]} {
    set SYN_SDC $SYN_SDC_CLK
} else {
    set SYN_SDC $SYN_SDC_DEF
}

set SYN_NETLIST     "${SYN_NET_DIR}/${TOP}_syn.v"
set SYN_NETLIST_DFT "${SYN_NET_DIR}/${TOP}_syn_dft.v"
set SYN_SDC_OUT     "${SYN_NET_DIR}/${TOP}_syn.sdc"
set SYN_SDC_OUT_DFT "${SYN_NET_DIR}/${TOP}_syn_dft.sdc"
set SYN_DDC         "${SYN_NET_DIR}/${TOP}_syn.ddc"
set SYN_DDC_DFT     "${SYN_NET_DIR}/${TOP}_syn_dft.ddc"
set SYN_SPF_DFT     "${SYN_NET_DIR}/${TOP}_syn_dft.spf"

# ---------- LEC（可依 CLK 分層）----------
set LEC_REPORT  "lec/report/${CLK_TAG}"
set LEC_SESSION "lec/session/${CLK_TAG}/${TOP}_lec.fss"

# ---------- TMAX ----------
set TMAX_REPORT  "tmax/report/${CLK_TAG}"
set TMAX_PATTERN "tmax/pattern/${CLK_TAG}/${TOP}_atpg.v"

# ---------- PrimeTime ----------
set PT_SCRIPT   "primetime/script"
set PT_SDC      "primetime/constraint/${TOP}.sdc"
set PT_SPEF     "primetime/spef/${CLK_TAG}/${TOP}.spef"
set PT_REPORT   "primetime/report/${CLK_TAG}"

# ---------- APR (Innovus) ----------
set APR_SCRIPT  "apr/script"
set APR_LIB     "apr/lib"
set APR_LEF     "apr/lef"
set APR_DEF     "apr/def/${CLK_TAG}/${TOP}.def"
set APR_GDS     "apr/gds/${CLK_TAG}/${TOP}.gds"
set APR_REPORT  "apr/report/${CLK_TAG}"

# ---------- 製程目錄 ----------
set TECH_DIR     "lib/${TECH}"
set LIB_MEMORY   "lib/memory"
set LIB_TECH     "lib/tech"

puts "INFO: \[setup.tcl\] TOP=$TOP  TECH=$TECH  CLK=$CLK  TAG=$CLK_TAG"
puts "INFO: \[setup.tcl\] SYN_SDC=$SYN_SDC"
puts "INFO: \[setup.tcl\] SYN_NETLIST=$SYN_NETLIST"
puts "INFO: \[setup.tcl\] SYN_NETLIST_DFT=$SYN_NETLIST_DFT"
puts "INFO: \[setup.tcl\] SYN_REPORT=$SYN_REPORT"
puts "INFO: \[setup.tcl\] SYN_DFT_REPORT=$SYN_DFT_REPORT"

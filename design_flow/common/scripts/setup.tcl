# ============================================================
# 共用路徑設定（嚴格相對路徑）
# ------------------------------------------------------------
# TECH : 製程（U18 / TSMC13 / ADFP / TN16 / TN7）
# CLK  : 時脈週期分層 → clk_<CLK>/
# SCAN : 0 = 一般 syn netlist；1 = DFT/scan netlist
# ============================================================

if {![info exists TOP]} {
    if {[info exists ::env(TOP)]} { set TOP $::env(TOP) } else { set TOP "DESIGN_TOP" }
}
if {![info exists TECH]} {
    if {[info exists ::env(TECH)]} { set TECH $::env(TECH) } else { set TECH "U18" }
}
if {![info exists CLK]} {
    if {[info exists ::env(CLK)]} { set CLK $::env(CLK) } else { set CLK "10" }
}
if {![info exists SCAN]} {
    if {[info exists ::env(SCAN)]} { set SCAN $::env(SCAN) } else { set SCAN "0" }
}

# 正規化 SCAN
if {$SCAN == 1 || $SCAN eq "1" || $SCAN eq "dft" || $SCAN eq "DFT"} {
    set SCAN 1
} else {
    set SCAN 0
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

# ---------- SYN：依 CLK 分層 ----------
set CLK_TAG        "clk_${CLK}"
set SYN_SCRIPT     "syn/script"
set SYN_NET_DIR    "syn/netlist/${CLK_TAG}"
set SYN_REPORT     "syn/report/${CLK_TAG}"
set SYN_DFT_REPORT "syn/dft_report/${CLK_TAG}"

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
set SYN_SDF         "${SYN_REPORT}/${TOP}_syn.sdf"
set SYN_SDF_DFT     "${SYN_REPORT}/${TOP}_syn_dft.sdf"

# ---------- SCAN 選擇作用中網表 / SDC / SDF / 報告子目錄 ----------
if {$SCAN == 1} {
    set NET_TAG          "dft"
    set ACTIVE_NETLIST   $SYN_NETLIST_DFT
    set ACTIVE_SDC_OUT   $SYN_SDC_OUT_DFT
    set ACTIVE_DDC       $SYN_DDC_DFT
    set ACTIVE_SDF       $SYN_SDF_DFT
    set ACTIVE_SVF       "${SYN_REPORT}/${TOP}_dft.svf"
} else {
    set NET_TAG          "syn"
    set ACTIVE_NETLIST   $SYN_NETLIST
    set ACTIVE_SDC_OUT   $SYN_SDC_OUT
    set ACTIVE_DDC       $SYN_DDC
    set ACTIVE_SDF       $SYN_SDF
    set ACTIVE_SVF       "${SYN_REPORT}/${TOP}.svf"
}

# 後段報告依 clk_* / syn|dft 分層，避免互相覆蓋
set LEC_REPORT  "lec/report/${CLK_TAG}/${NET_TAG}"
set LEC_SESSION "lec/session/${CLK_TAG}/${NET_TAG}/${TOP}_lec.fss"
set TMAX_REPORT  "tmax/report/${CLK_TAG}/${NET_TAG}"
set TMAX_PATTERN "tmax/pattern/${CLK_TAG}/${NET_TAG}/${TOP}_atpg.v"
set PT_REPORT   "primetime/report/${CLK_TAG}/${NET_TAG}"
set PT_SPEF     "primetime/spef/${CLK_TAG}/${NET_TAG}/${TOP}.spef"
set PT_SDC      "primetime/constraint/${TOP}.sdc"
set APR_DEF     "apr/def/${CLK_TAG}/${NET_TAG}/${TOP}.def"
set APR_GDS     "apr/gds/${CLK_TAG}/${NET_TAG}/${TOP}.gds"
set APR_REPORT  "apr/report/${CLK_TAG}/${NET_TAG}"
set APR_SCRIPT  "apr/script"
set APR_LIB     "apr/lib"
set APR_LEF     "apr/lef"

# DFT 常見 test port 名稱（LEC 設 constant 用；可在 -x 覆寫）
if {![info exists SCAN_EN_PORTS]} {
    set SCAN_EN_PORTS {scan_en SE se test_se}
}
if {![info exists TEST_MODE_PORTS]} {
    set TEST_MODE_PORTS {test_mode tm TEST_MODE}
}

# ---------- 製程目錄 ----------
set TECH_DIR     "lib/${TECH}"
set LIB_MEMORY   "lib/memory"
set LIB_TECH     "lib/tech"

puts "INFO: \[setup.tcl\] TOP=$TOP TECH=$TECH CLK=$CLK SCAN=$SCAN NET_TAG=$NET_TAG"
puts "INFO: \[setup.tcl\] ACTIVE_NETLIST=$ACTIVE_NETLIST"
puts "INFO: \[setup.tcl\] ACTIVE_SDC_OUT=$ACTIVE_SDC_OUT"
puts "INFO: \[setup.tcl\] ACTIVE_SDF=$ACTIVE_SDF"

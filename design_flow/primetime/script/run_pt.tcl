# ============================================================
# PrimeTime STA
# 輸入串接：syn/netlist/${TOP}_syn.v + syn constraint / syn sdc_out
# 執行：cd primetime/script && pt_shell -f run_pt.tcl
# ============================================================

cd ../..
source common/scripts/setup.tcl

file mkdir primetime/report
file mkdir primetime/constraint
file mkdir primetime/spef

if {![file exists $SYN_NETLIST]} {
    puts "ERROR: 找不到合成網表: $SYN_NETLIST"
    puts "ERROR: 請先執行 make syn"
    exit 1
}

# ---------- Library（相對路徑）----------
set_app_var search_path ". $LIB_STDCELL"
set_app_var link_path   "* $LINK_LIB_FILE"

# ---------- Design ----------
read_verilog $SYN_NETLIST
link_design $TOP
current_design $TOP

# 優先使用 SYN 寫出的 SDC；若無則退回 syn/constraint
if {[file exists $SYN_SDC_OUT]} {
    puts "INFO: source $SYN_SDC_OUT"
    source $SYN_SDC_OUT
} elseif {[file exists $SYN_SDC]} {
    puts "INFO: source $SYN_SDC"
    source $SYN_SDC
} else {
    puts "ERROR: 找不到 SDC"
    exit 1
}

# 若有 post-layout SPEF（相對路徑），讀入後做較準確 STA
if {[file exists $PT_SPEF]} {
    puts "INFO: read_parasitics $PT_SPEF"
    read_parasitics $PT_SPEF
} else {
    puts "INFO: 無 SPEF，進行 pre-layout STA"
}

update_timing

# ---------- Reports ----------
report_timing -delay_type max -max_paths 50 > $PT_REPORT/timing_max.rpt
report_timing -delay_type min -max_paths 50 > $PT_REPORT/timing_min.rpt
report_constraint -all_violators            > $PT_REPORT/violators.rpt
report_clock                                > $PT_REPORT/clock.rpt
report_qor                                  > $PT_REPORT/qor.rpt
report_global_timing                        > $PT_REPORT/global_timing.rpt

puts "INFO: PrimeTime done. reports -> $PT_REPORT"
exit

# ============================================================
# TetraMAX ATPG
# 輸入串接：syn/netlist/${TOP}_syn.v
# 執行：cd tmax/script && tmax -shell run_tmax.tcl
# ============================================================

cd ../..
source common/scripts/setup.tcl

file mkdir tmax/report
file mkdir tmax/pattern

if {![file exists $SYN_NETLIST]} {
    puts "ERROR: 找不到合成網表: $SYN_NETLIST"
    puts "ERROR: 請先執行 make syn"
    exit 1
}

# ---------- Build / DRC / ATPG ----------
read_netlist $SYN_NETLIST
run_build_model $TOP
run_drc

# Stuck-at 為競賽 / 入門 DFT 常見設定
set_faults -model stuck
add_faults -all

run_atpg -auto_compression

# ---------- Output ----------
report_summaries               > $TMAX_REPORT/summary.rpt
report_faults -summary         > $TMAX_REPORT/fault_summary.rpt
report_faults -level 4 100     > $TMAX_REPORT/fault_detail.rpt

write_patterns $TMAX_PATTERN -format verilog_single_file -replace

puts "INFO: TetraMAX done."
puts "INFO: pattern = $TMAX_PATTERN"
puts "INFO: report  = $TMAX_REPORT"
exit

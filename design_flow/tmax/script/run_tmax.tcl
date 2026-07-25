# ============================================================
# TetraMAX ATPG
# SCAN=1（建議）→ *_syn_dft.v ；SCAN=0 → *_syn.v
# 執行：make tmax CLK=10 SCAN=1
# ============================================================

cd ../..
source common/scripts/setup.tcl

file mkdir $TMAX_REPORT
file mkdir [file dirname $TMAX_PATTERN]

if {![file exists $ACTIVE_NETLIST]} {
    puts "ERROR: 找不到網表: $ACTIVE_NETLIST"
    puts "ERROR: ATPG 請用 SCAN=1 並先 make syn_dft CLK=$CLK"
    exit 1
}

if {$SCAN == 0} {
    puts "WARN: 目前 SCAN=0（預設不用 scan）。ATPG 通常需要 scan chain："
    puts "WARN:   make syn_dft CLK=$CLK && make tmax SCAN=1 CLK=$CLK"
}

puts "INFO: ATPG 使用網表 SCAN=$SCAN → $ACTIVE_NETLIST"

# if {[file exists $SYN_SPF_DFT] && $SCAN == 1} {
#   run_drc $SYN_SPF_DFT
# }

read_netlist $ACTIVE_NETLIST
run_build_model $TOP
run_drc

set_faults -model stuck
add_faults -all
run_atpg -auto_compression

report_summaries               > $TMAX_REPORT/summary.rpt
report_faults -summary         > $TMAX_REPORT/fault_summary.rpt
report_faults -level 4 100     > $TMAX_REPORT/fault_detail.rpt
write_patterns $TMAX_PATTERN -format verilog_single_file -replace

puts "INFO: TetraMAX done. SCAN=$SCAN"
puts "INFO: pattern = $TMAX_PATTERN"
puts "INFO: report  = $TMAX_REPORT"
exit

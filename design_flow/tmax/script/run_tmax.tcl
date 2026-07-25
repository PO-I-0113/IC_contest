# ============================================================
# TetraMAX ATPG（單一路徑本）
#   make tmax      → NET_TAG=syn（通常不建議）
#   make tmax_dft  → NET_TAG=dft（建議）
# ============================================================

cd ../..
source common/scripts/setup.tcl

file mkdir $TMAX_REPORT
file mkdir [file dirname $TMAX_PATTERN]

if {![file exists $ACTIVE_NETLIST]} {
    puts "ERROR: 找不到網表: $ACTIVE_NETLIST"
    puts "ERROR: 請先 make syn_dft CLK=$CLK 再 make tmax_dft"
    exit 1
}

if {$NET_TAG eq "syn"} {
    puts "WARN: 目前為 syn 網表。ATPG 建議："
    puts "WARN:   make syn_dft CLK=$CLK && make tmax_dft CLK=$CLK"
}

puts "INFO: ATPG NET_TAG=$NET_TAG → $ACTIVE_NETLIST"

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

puts "INFO: TetraMAX done. NET_TAG=$NET_TAG"
puts "INFO: pattern = $TMAX_PATTERN"
exit

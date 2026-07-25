# ============================================================
# TetraMAX ATPG
# 優先讀取 DFT netlist：syn/netlist/clk_<CLK>/${TOP}_syn_dft.v
# 若無則退回一般合成網表
# 執行：make tmax CLK=10
# ============================================================

cd ../..
source common/scripts/setup.tcl

file mkdir $TMAX_REPORT
file mkdir [file dirname $TMAX_PATTERN]

# 優先 DFT netlist（scan chain），否則一般 syn netlist
if {[file exists $SYN_NETLIST_DFT]} {
    set ATPG_NETLIST $SYN_NETLIST_DFT
    puts "INFO: 使用 DFT netlist: $ATPG_NETLIST"
} elseif {[file exists $SYN_NETLIST]} {
    set ATPG_NETLIST $SYN_NETLIST
    puts "WARN: 無 DFT netlist，改用一般合成網表: $ATPG_NETLIST"
    puts "WARN: 建議先 make syn_dft CLK=$CLK"
} else {
    puts "ERROR: 找不到網表:"
    puts "ERROR:   $SYN_NETLIST_DFT"
    puts "ERROR:   $SYN_NETLIST"
    puts "ERROR: 請先 make syn_dft CLK=$CLK 或 make syn CLK=$CLK"
    exit 1
}

# 若有 SPF / test protocol，可在此讀取（依 TetraMAX 版本調整）
# if {[file exists $SYN_SPF_DFT]} {
#   run_drc $SYN_SPF_DFT
# }

# ---------- Build / DRC / ATPG ----------
read_netlist $ATPG_NETLIST
run_build_model $TOP
run_drc

set_faults -model stuck
add_faults -all

run_atpg -auto_compression

# ---------- Output ----------
report_summaries               > $TMAX_REPORT/summary.rpt
report_faults -summary         > $TMAX_REPORT/fault_summary.rpt
report_faults -level 4 100     > $TMAX_REPORT/fault_detail.rpt

write_patterns $TMAX_PATTERN -format verilog_single_file -replace

puts "INFO: TetraMAX done. CLK=$CLK"
puts "INFO: pattern = $TMAX_PATTERN"
puts "INFO: report  = $TMAX_REPORT"
exit

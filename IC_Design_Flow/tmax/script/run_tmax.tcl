# ============================================================
# TetraMAX ATPG 模板
# ============================================================

set TOP     "DESIGN_TOP"
set ROOT    [file normalize [file join [pwd] ../..]]
set NETLIST [file join $ROOT syn netlist ${TOP}_syn.v]
set RPT_DIR [file join $ROOT tmax report]
set PAT_DIR [file join $ROOT tmax pattern]

file mkdir $RPT_DIR
file mkdir $PAT_DIR

# read_netlist $NETLIST
# run_build_model $TOP
# run_drc
# set_faults -model stuck
# run_atpg -auto_compression
# report_faults -summary > [file join $RPT_DIR fault_summary.rpt]
# write_patterns [file join $PAT_DIR ${TOP}_atpg.v] -format verilog_single_file

puts "INFO: TetraMAX template loaded. TOP=$TOP"
puts "INFO: Edit tmax/script/run_tmax.tcl before running."
exit

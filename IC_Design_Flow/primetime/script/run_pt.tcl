# ============================================================
# PrimeTime STA 模板
# ============================================================

set TOP     "DESIGN_TOP"
set ROOT    [file normalize [file join [pwd] ../..]]
set NETLIST [file join $ROOT syn netlist ${TOP}_syn.v]
set SDC     [file join $ROOT syn constraint ${TOP}.sdc]
set SPEF    [file join $ROOT primetime spef ${TOP}.spef]
set RPT_DIR [file join $ROOT primetime report]

file mkdir $RPT_DIR

# ---------- Library ----------
# set_app_var search_path ".../lib/stdcell"
# set_app_var link_path   "* slow.db"

# ---------- Design ----------
# read_verilog $NETLIST
# link_design $TOP
# source $SDC

# ---------- Parasitic（post-layout 才需要）----------
# if {[file exists $SPEF]} {
#   read_parasitics $SPEF
# }

# update_timing

# report_timing -max_paths 100 > [file join $RPT_DIR timing_max.rpt]
# report_timing -delay_type min -max_paths 100 > [file join $RPT_DIR timing_min.rpt]
# report_constraint -all_violators > [file join $RPT_DIR violators.rpt]
# report_qor > [file join $RPT_DIR qor.rpt]

puts "INFO: PrimeTime template loaded. TOP=$TOP"
puts "INFO: Edit primetime/script/run_pt.tcl before running."
exit

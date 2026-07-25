# ============================================================
# Formality LEC 模板
# Golden  : RTL
# Revised : Synthesis netlist
# ============================================================

set TOP      "DESIGN_TOP"
set ROOT     [file normalize [file join [pwd] ../..]]
set RTL_DIR  [file join $ROOT rtl src]
set INC_DIR  [file join $ROOT rtl include]
set NETLIST  [file join $ROOT syn netlist ${TOP}_syn.v]
set RPT_DIR  [file join $ROOT lec report]
set SES_DIR  [file join $ROOT lec session]

file mkdir $RPT_DIR
file mkdir $SES_DIR

# 建議流程：
# 1) read_container -r (golden / RTL)
# 2) read_container -i (revised / netlist)
# 3) set_top
# 4) match
# 5) verify
# 6) report / save session

# ---------- Golden (RTL) ----------
# read_sverilog -container r -libname WORK -12 \
#   [glob $RTL_DIR/*.v]
# set_top r:/WORK/$TOP

# ---------- Revised (Netlist) ----------
# read_verilog -container i -libname WORK $NETLIST
# set_top i:/WORK/$TOP

# ---------- Match & Verify ----------
# match
# verify

# ---------- Reports ----------
# report_passing_points   > [file join $RPT_DIR passing.rpt]
# report_failing_points   > [file join $RPT_DIR failing.rpt]
# report_aborted_points   > [file join $RPT_DIR aborted.rpt]
# report_unmatched_points > [file join $RPT_DIR unmatched.rpt]

# save_session [file join $SES_DIR ${TOP}_lec.fss]

puts "INFO: Formality LEC template loaded. TOP=$TOP"
puts "INFO: Netlist expected at: $NETLIST"
puts "INFO: Edit lec/script/run_lec.tcl before running."
exit

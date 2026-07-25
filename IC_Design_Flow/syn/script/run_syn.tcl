# ============================================================
# Design Compiler 合成模板
# ============================================================

set TOP      "DESIGN_TOP"
set ROOT     [file normalize [file join [pwd] ../..]]
set RTL_DIR  [file join $ROOT rtl src]
set INC_DIR  [file join $ROOT rtl include]
set SDC      [file join $ROOT syn constraint ${TOP}.sdc]
set NET_DIR  [file join $ROOT syn netlist]
set RPT_DIR  [file join $ROOT syn report]

file mkdir $NET_DIR
file mkdir $RPT_DIR

# ---------- Library（請改成實際路徑）----------
# set SEARCH_PATH ".../lib/stdcell"
# set TARGET_LIB  "slow.db"
# set LINK_LIB    "* $TARGET_LIB"
# set_app_var search_path    $SEARCH_PATH
# set_app_var target_library $TARGET_LIB
# set_app_var link_library   $LINK_LIB

# ---------- Read RTL ----------
# analyze -format verilog -define {} [glob $RTL_DIR/*.v]
# elaborate $TOP
# current_design $TOP
# link

# ---------- Constraint ----------
# source $SDC

# ---------- Compile ----------
# compile_ultra -gate_clock
# # 或 compile

# ---------- Output ----------
# write -format verilog -hierarchy -output [file join $NET_DIR ${TOP}_syn.v]
# write_sdc [file join $NET_DIR ${TOP}_syn.sdc]
# write -format ddc -hierarchy -output [file join $NET_DIR ${TOP}_syn.ddc]

# ---------- Reports ----------
# report_timing  > [file join $RPT_DIR timing.rpt]
# report_area    > [file join $RPT_DIR area.rpt]
# report_power   > [file join $RPT_DIR power.rpt]
# report_qor     > [file join $RPT_DIR qor.rpt]

puts "INFO: DC template loaded. TOP=$TOP"
puts "INFO: Edit syn/script/run_syn.tcl (library/read/compile) before running."
exit

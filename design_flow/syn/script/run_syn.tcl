# ============================================================
# Design Compiler — compile_ultra（無 scan）
# 執行：make syn TECH=U18 CLK=10
# 產出：syn/netlist/clk_<CLK>/${TOP}_syn.v
#       syn/report/clk_<CLK>/
# ============================================================

cd ../..
source common/scripts/setup.tcl

set TECH_TOOL "dc"
source common/scripts/load_tech.tcl

file mkdir $SYN_NET_DIR
file mkdir $SYN_REPORT

# ---------- Read RTL ----------
analyze -format verilog $RTL_DIR/${TOP}.v
elaborate $TOP
current_design $TOP
link
uniquify
check_design > $SYN_REPORT/check_design.rpt

# ---------- Constraint ----------
if {![file exists $SYN_SDC]} {
    puts "ERROR: 找不到 SDC: $SYN_SDC"
    puts "ERROR: 可放 syn/constraint/${TOP}_clk${CLK}.sdc 或 ${TOP}.sdc"
    exit 1
}
puts "INFO: source $SYN_SDC"
source $SYN_SDC

# ---------- Compile ----------
set_svf $SYN_REPORT/${TOP}.svf
compile_ultra -gate_clock
# compile_ultra
set_svf -off

# ---------- Output ----------
write -format verilog -hierarchy -output $SYN_NETLIST
write_sdc $SYN_SDC_OUT
write -format ddc -hierarchy -output $SYN_DDC
write_sdf $SYN_REPORT/${TOP}_syn.sdf

# ---------- Reports ----------
report_timing  -max_paths 20 > $SYN_REPORT/timing.rpt
report_area                  > $SYN_REPORT/area.rpt
report_power                 > $SYN_REPORT/power.rpt
report_constraint -all_violators > $SYN_REPORT/constraint.rpt
report_qor                   > $SYN_REPORT/qor.rpt
report_reference             > $SYN_REPORT/reference.rpt

puts "INFO: SYN done. TECH=$TECH CLK=$CLK"
puts "INFO: netlist = $SYN_NETLIST"
puts "INFO: report  = $SYN_REPORT"
exit

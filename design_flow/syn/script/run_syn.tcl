# ============================================================
# Design Compiler — compile_ultra
# 執行：make syn TECH=tsmc18
# 路徑：一律相對 design_flow/
# 產出：syn/netlist/${TOP}_syn.v  → 供 LEC / PT / TMAX / APR 串接
# ============================================================

# 切回 design_flow 根目錄
cd ../..
source common/scripts/setup.tcl

# 載入製程 library setup（lib/<TECH>/setup_dc.tcl）
set TECH_TOOL "dc"
source common/scripts/load_tech.tcl

file mkdir syn/netlist
file mkdir syn/report

# ---------- Read RTL ----------
# defines.vh 透過 search_path / `include 引入，不單獨 analyze
analyze -format verilog $RTL_DIR/${TOP}.v
elaborate $TOP
current_design $TOP
link
uniquify
check_design > $SYN_REPORT/check_design.rpt

# ---------- Constraint ----------
if {![file exists $SYN_SDC]} {
    puts "ERROR: 找不到 SDC: $SYN_SDC"
    exit 1
}
source $SYN_SDC

# ---------- Compile ----------
# SVF 供 Formality 使用（相對路徑）
set_svf $SYN_REPORT/${TOP}.svf

# 競賽 / 一般 RTL-to-gate 常用 compile_ultra
compile_ultra -gate_clock
# 若 library 不支援 gate clock，可改：
# compile_ultra

set_svf -off

# ---------- Output（串接用）----------
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

puts "INFO: SYN done. TECH=$TECH"
puts "INFO: netlist = $SYN_NETLIST"
puts "INFO: sdc_out = $SYN_SDC_OUT"
exit

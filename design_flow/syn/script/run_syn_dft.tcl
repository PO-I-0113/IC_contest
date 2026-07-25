# ============================================================
# Design Compiler — 合成 + Scan Chain（DFT）
# 執行：make syn_dft TECH=U18 CLK=10
# 產出：
#   syn/netlist/clk_<CLK>/${TOP}_syn_dft.v
#   syn/report/clk_<CLK>/          （一般時序/面積報告）
#   syn/dft_report/clk_<CLK>/      （DFT / scan 專用報告）
# ============================================================

cd ../..
source common/scripts/setup.tcl

set TECH_TOOL "dc"
source common/scripts/load_tech.tcl

file mkdir $SYN_NET_DIR
file mkdir $SYN_REPORT
file mkdir $SYN_DFT_REPORT

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
    exit 1
}
puts "INFO: source $SYN_SDC"
source $SYN_SDC

# ============================================================
# DFT / Scan Chain 設定（依 port 名稱調整）
# 預設假設：clk = ScanClock, rst = 高有效 Reset
# ============================================================

# Scan clock（既有功能時脈當 scan clock）
set_dft_signal -view existing_dft -type ScanClock \
    -timing {45 55} -port [get_ports clk]

# Reset（非同步高有效；若低有效改 active_state 0）
set_dft_signal -view existing_dft -type Reset \
    -active_state 1 -port [get_ports rst]

# 若有獨立 test_mode / scan_en，可取消註解並改 port 名：
# set_dft_signal -view spec -type Constant -active_state 1 -port [get_ports test_mode]
# set_dft_signal -view spec -type ScanEnable -active_state 1 -port [get_ports scan_en]

create_test_protocol
dft_drc > $SYN_DFT_REPORT/dft_drc_pre.rpt

# Scan 架構（依需求調整 chain 數）
set_dft_configuration -fix_enable enable -scan enable
set_scan_configuration -style multiplexed_flip_flop -chain_count 1
# set_scan_configuration -clock_mixing no_mix

preview_dft > $SYN_DFT_REPORT/preview_dft.rpt

# ---------- Compile with scan + insert DFT ----------
set_svf $SYN_REPORT/${TOP}_dft.svf

# 先做 scan-ready 合成
compile_ultra -scan -gate_clock
# 若 library / 流程不支援 -scan，可改：
# compile_ultra -gate_clock

# 插入 scan chain
insert_dft
dft_drc > $SYN_DFT_REPORT/dft_drc_post.rpt

set_svf -off

# ---------- Output（DFT netlist）----------
change_names -rules verilog -hierarchy
write -format verilog -hierarchy -output $SYN_NETLIST_DFT
write_sdc $SYN_SDC_OUT_DFT
write -format ddc -hierarchy -output $SYN_DDC_DFT
write_sdf $SYN_REPORT/${TOP}_syn_dft.sdf

# Test protocol / SPF（給 TetraMAX 等使用）
write_test_protocol -output $SYN_SPF_DFT

# ---------- 一般 Reports → syn/report/clk_* ----------
report_timing  -max_paths 20 > $SYN_REPORT/timing_dft.rpt
report_area                  > $SYN_REPORT/area_dft.rpt
report_power                 > $SYN_REPORT/power_dft.rpt
report_qor                   > $SYN_REPORT/qor_dft.rpt
report_constraint -all_violators > $SYN_REPORT/constraint_dft.rpt

# ---------- DFT Reports → syn/dft_report/clk_* ----------
report_dft_signal            > $SYN_DFT_REPORT/dft_signal.rpt
report_scan_configuration    > $SYN_DFT_REPORT/scan_configuration.rpt
report_scan_path -view existing_dft -chain all \
                             > $SYN_DFT_REPORT/scan_path.rpt
report_scan_path -view existing_dft -chain all -verbose \
                             > $SYN_DFT_REPORT/scan_path_verbose.rpt
report_dft_configuration     > $SYN_DFT_REPORT/dft_configuration.rpt

puts "INFO: SYN+DFT done. TECH=$TECH CLK=$CLK"
puts "INFO: netlist     = $SYN_NETLIST_DFT"
puts "INFO: report      = $SYN_REPORT"
puts "INFO: dft_report  = $SYN_DFT_REPORT"
puts "INFO: test proto  = $SYN_SPF_DFT"
exit

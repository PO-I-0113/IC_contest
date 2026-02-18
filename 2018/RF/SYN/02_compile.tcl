# ============================================================================
# 解決多重實例問題
# ============================================================================
check_design
uniquify

# ============================================================================
# 預綜合設置
# ============================================================================
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]
set high_fanout_net_threshold 0


# Dont touch IOPad
#set_dont_touch [get_cell ipad*]
#set_dont_touch [get_cell opad*]

# ============================================================================
# 設計檢查
# ============================================================================
check_design > ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$RPT_DIR/check_design.log
check_timing > ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$RPT_DIR/check_timing.log

# ============================================================================
# Scan Chain 插入設置
# ============================================================================
# 指定 ATE 時序
set test_default_delay 0
set test_default_bidir_dealy 0
set test_default_strobe 40
set test_default_period 100

# 創建 scan chain 端口
create_port test_se
create_port -direction in {test_si}
create_port -direction out {test_so}

# 設置 scan clock 時序
set_dft_signal -view existing_dft -type ScanClock -timing [ list 45 55] -port clk
set_dft_signal -view existing_dft -type Reset -port [get_ports rst] -active_state 1

# 創建測試協議
create_test_protocol -infer_asynch -infer_clock

# 檢查 DRC 規則（pre-DFT）
#set_dft_drc_configuration -mode pre_dft
#dft_drc -verbose > ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$DFT_RPT_DIR/report_drc_pre.rpt

# 指定 scan chain 配置
set_scan_configuration -chain_count 1
set_scan_configuration -style multiplexed_flip_flop
set_dft_configuration -fix_clock enable
set_autofix_configuration -type clock

# 設置 DFT 信號
#set_dft_signal -type ScanClock -port clk
#set_dft_signal -type ScanEnable -port test_se
#set_dft_signal -type ScanIn -port test_si
#set_dft_signal -type ScanOut -port test_so
set_dft_signal -view spec -port "test_si" -type ScanDataIn  
set_dft_signal -view spec -port "test_so" -type ScanDataOut
set_dft_signal -view spec -port "test_se" -type ScanEnable -active_state 1

set_false_path -from [get_ports test_se]

# ============================================================================
# 綜合（帶 scan chain）
# ============================================================================
# 使用 compile -scan 以支持 scan chain 插入
compile_ultra -scan 
#report_unmapped
insert_dft
#-map_effort high
#-area_effort high
#-inc
#-only_hold_time
#-boundary_optimization
#-gate_clock
#-scan
compile_ultra -incremental
# 備選綜合選項
#compile_ultra 
#compile -scan
#-no_autoungroup
#-no_boundary_optimization
#-retime

# ============================================================================
# 名稱規則設置
# ============================================================================
change_names -hierarchy -rule verilog
define_name_rules name_rule -case_insensitive
change_names -hierarchy -rules name_rule

# ============================================================================
# 電源優化
# ============================================================================
#Power Optimization
#set_dynamic_optimization true
#set_leakage_optimization true
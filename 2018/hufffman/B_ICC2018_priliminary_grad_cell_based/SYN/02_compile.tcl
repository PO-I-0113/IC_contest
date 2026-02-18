#set_high_fanout_net_threshold 0

# Solve Multiple Instance
uniquify

# Pre Synthesis Settings
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]

# Dont touch IOPad
#set_dont_touch [get_cell ipad*]
#set_dont_touch [get_cell opad*]
set_ungroup FSM1 false
set_ungroup cnt false
set_ungroup sort_counter false
set_ungroup pointer false
set_ungroup sorter false
set_ungroup group_devider false
set_ungroup serial_counter false

# Check Design
check_design > ./$RPT_DIR/check_design.log
check_timing > ./$RPT_DIR/check_timing.log

# Specofy ATE timing
set test_default_delay 0
set test_default_bidir_dealy 0
set test_default_strobe 40
set test_default_period 100

#create_port test_se
#create_port -direction in {test_si}
#create_port -direction out {test_so}
# Setup the timing of scan clock
set_dft_signal -view existing_dft -type ScanClock -timing [ list 45 55] -port clk
set_dft_signal -view existing_dft -type Reset -port [get_ports reset] -active_state 1

# Creat test protocol
create_test_protocol -infer_asynch -infer_clock

# Check drc rule
#set_dft_drc_configuration -mode pre_dft
dft_drc -verbose > ./$DFT_DIR/report_drc_pre.rpt

# Specify the number of scan chains and the type of scan cell
set_scan_configuration -chain_count 1
set_scan_configuration -style multiplexed_flip_flop
set_dft_configuration -fix_clock enable
set_autofix_configuration -type clock

#set_dft_signal -type ScanClock -port clk
#set_dft_signal -type ScanEnable -port test_se
#set_dft_signal -type ScanIn -port test_si
#set_dft_signal -type ScanOut -port test_so
set_dft_signal -view spec -port "test_si" -type ScanDataIn  
set_dft_signal -view spec -port "test_so" -type ScanDataOut
set_dft_signal -view spec -port "test_se" -type ScanEnable -active_state 1

set_false_path -from [get_ports test_se]
# Synthesis
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

#compile -scan
#-no_autoungroup
#-no_boundary_optimization
#-retime

#Power Optimization
#set_dynamic_optimization true
#set_leakage_optimization true
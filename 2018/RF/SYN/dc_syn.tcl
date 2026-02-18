set VERSION pipeline_signed_final_version_div_code
set CONSTRAIN 5
set TOPLEVEL RFILE
set HDL_DIR RTL
set RPT_DIR report
set NET_DIR netlist
set TECH TSMC13
set SCAN no_scan_chain


# ============================================================================
# 目錄設置與清理（整合自 dc_syn_pipe.tcl）
# ============================================================================
sh rm -rf ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$NET_DIR
sh rm -rf ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$RPT_DIR
sh mkdir -p ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN
sh mkdir ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$NET_DIR
sh mkdir ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$RPT_DIR

set_host_option -max_cores 16

remove_design -designs
#Read All Files
read_file -format verilog  ../$HDL_DIR/RFILE_$VERSION.v
#read_file -format sverilog  RFILE.v
#analyze -library WORK -format verilog ../RTL/RFILE_$VERSION.v
#elaborate $TOPLEVEL -architecture verilog -library WORK
current_design $TOPLEVEL
link
#Setting Clock Constraints
source -echo -verbose ./RFILE_APR.sdc
check_design
set high_fanout_net_threshold 0
uniquify
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]
#set_max_area 0
#Synthesis all design
#compile -map_effort high -area_effort high
#compile -map_effort high -area_effort high -inc
compile_ultra 
compile_ultra -incremental
#compile_ultra -retime
change_names -hierarchy -rule verilog
define_name_rules name_rule -case_insensitive
change_names -hierarchy -rules name_rule

#Each Pipeline Delay 

#uplevel #0 { report_timing  -through { valid_controlor/* } -path full -delay max -nworst 1 -max_paths 1 -significant_digits 2 -sort_by group} > ./$VERSION/$TECH/clk_$CONSTRAIN/$REPORT/timing_report_valid_controlor.txt
#uplevel #0 { report_timing  -through { counter_tester/* } -path full -delay max -nworst 1 -max_paths 1 -significant_digits 2 -sort_by group } > ./$VERSION/$TECH/clk_$CONSTRAIN/$REPORT/timing_report_counter_tester.txt
#uplevel #0 { report_timing  -through { complementer/* } -path full -delay max -nworst 1 -max_paths 1 -significant_digits 2 -sort_by group }   > ./$VERSION/$TECH/clk_$CONSTRAIN/$REPORT/timing_report_complementer.txt
#uplevel #0 { report_timing  -through { caler_exp/* } -path full -delay max -nworst 1 -max_paths 1 -significant_digits 2 -sort_by group }      > ./$VERSION/$TECH/clk_$CONSTRAIN/$REPORT/timing_report_caler_exp.txt
#uplevel #0 { report_timing  -through { cal_distancer/* } -path full -delay max -nworst 1 -max_paths 1 -significant_digits 2 -sort_by group }  > ./$VERSION/$TECH/clk_$CONSTRAIN/$REPORT/timing_report_cal_distancer.txt
#uplevel #0 { report_timing  -through { locationor/* } -path full -delay max -nworst 1 -max_paths 1 -significant_digits 2 -sort_by group }     > ./$VERSION/$TECH/clk_$CONSTRAIN/$REPORT/timing_report_locationor.txt
#uplevel #0 { report_timing  -through { constant_calculater/* } -path full -delay max -nworst 1 -max_paths 1 -significant_digits 2 -sort_by group }     > ./$VERSION/$TECH/clk_$CONSTRAIN/$REPORT/timing_report_constant_calculater.txt
write -format ddc     -hierarchy -output ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$NET_DIR/RFILE_syn.ddc
write_sdf -version 2.1  ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$NET_DIR/RFILE_syn.sdf
write -format verilog -hierarchy -output  ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$NET_DIR/RFILE_syn.v
write_sdc -version 1.5 ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$NET_DIR/RFILE_syn.sdc
report_area  -hierarchy >  ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$RPT_DIR/report_area.rpt
report_timing > ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$RPT_DIR/report_timing.rpt
report_power > ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$RPT_DIR/report_power.rpt
report_qor   >  ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$RPT_DIR/RFILE_syn.qor
report_timing -sign 4 -delay_type min > ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$RPT_DIR/report_hold_time.rpt

exit

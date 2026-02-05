#Read All Files

rm -rf ../SYN/report/
rm -rf ../SYN/netlist/
mkdir -p ../SYN/report/
mkdir -p ../SYN/netlist/


read_file -format verilog  ../RTL/Bicubic.v
#read_file -format sverilog  Bicubic.v
current_design Bicubic
link

ungroup -all
#Setting Clock Constraints
uniquify
check_design

source -echo -verbose Bicubic.sdc
set_fix_hold                [all_clocks]

set high_fanout_net_threshold 0
set_host_options -max_cores 16


set_fix_multiple_port_nets -all -buffer_constants [get_designs *]
#set_max_area 0
#Synthesis all design
#compile -map_effort high -area_effort high
#compile -map_effort high -area_effort high -inc
compile_ultra

write -format ddc     -hierarchy -output "../SYN/report/Bicubic_syn.ddc"
write_sdf -version 1.0  ../SYN/netlist/Bicubic_syn.sdf
write -format verilog -hierarchy -output "../SYN/netlist/Bicubic_syn.v"
report_area > "../SYN/report/area.rpt"
report_timing -delay_type min > "../SYN/report/hold_timing.rpt"
report_timing > "../SYN/report/timing.rpt"
report_qor   >  "../SYN/report/Bicubic_syn.qor"

exit
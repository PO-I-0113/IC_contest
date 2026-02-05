#Read All Files
read_file -format sverilog  ../RTL/SME.sv
current_design SME
link

#Setting Clock Constraints
source -echo -verbose SME.sdc
check_design
set high_fanout_net_threshold 0
uniquify
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]
ungroup -all
#Synthesis all design
#compile -map_effort high -area_effort high
#compile -map_effort high -area_effort high -inc
compile

write -format ddc     -hierarchy -output "SME_syn.ddc"
write_sdf -version 1.0  SME_syn.sdf
write -format verilog -hierarchy -output SME_syn.v
report_area -hierarchy > area.log
report_timing > timing.log
report_qor   >  SME_syn.qor

print_message_info -ids *-summary
# Read all Files
read_verilog ../RTL/IOTDF.v
current_design IOTDF
link

set_svf ./IOTDF.svf
# Setting Clock Constraits
source -echo -verbose IOTDF_DC.sdc

# Synthesis all design
#compile -map_effort high -area_effort high
#compile -map_effort high -area_effort high -inc
#set_ungroup FSM_control false
#set_ungroup calculate false
#set_ungroup sort_count false
#set_ungroup point false
#set_ungroup sort false
#set_ungroup group_devide false
ungroup -all
compile
report_area -hierarchy > ./report_area.rpt
report_power 		   > ./report_power.rpt
report_timing          > ./report_timing.rpt

write -format ddc  -hierarchy -output "IOTDF_syn.ddc"
write_sdf "IOTDF_syn.sdf"
write_file -format verilog -hierarchy -output IOTDF_syn.v
set_svf ./IOTDF.svf
#
#report_area -hierarchy  > /home/pit116/B_ICC2018_priliminary_grad_cell_based/third_version_15_state/SYN/report_130_gating/area.rpt
#report_power 		    > /home/pit116/B_ICC2018_priliminary_grad_cell_based/third_version_15_state/SYN/report_130_gating/power.rpt
#report_timing 			> /home/pit116/B_ICC2018_priliminary_grad_cell_based/third_version_15_state/SYN/report_130_gating/timing.rpt

exit
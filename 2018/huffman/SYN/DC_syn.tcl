# Read all Files
read_verilog ../RTL/huffman.v
current_design huffman
link

set_svf ./U18_huffman.svf
# Setting Clock Constraits
source -echo -verbose huffman.sdc

# Synthesis all design
#compile -map_effort high -area_effort high
#compile -map_effort high -area_effort high -inc
#set_ungroup FSM_control false
#set_ungroup calculate false
#set_ungroup sort_count false
#set_ungroup point false
#set_ungroup sort false
#set_ungroup group_devide false

compile
report_area -hierarchy  > /home/pit116/U18_chip/huffman/SYN/report/report_area.rpt
report_power 		    > /home/pit116/U18_chip/huffman/SYN/report/report_power.rpt
report_timing           > /home/pit116/U18_chip/huffman/SYN/report/report_timing.rpt
report_qor 				> /home/pit116/U18_chip/huffman/SYN/huffman_syn.qor

write -format ddc  -hierarchy -output "huffman_syn.ddc"
write_sdf "huffman_syn.sdf"
write_file -format verilog -hierarchy -output huffman_syn.v
set_svf ./U18_huffman.svf
#
#report_area -hierarchy  > /home/pit116/B_ICC2018_priliminary_grad_cell_based/third_version_15_state/SYN/report_130_gating/area.rpt
#report_power 		    > /home/pit116/B_ICC2018_priliminary_grad_cell_based/third_version_15_state/SYN/report_130_gating/power.rpt
#report_timing 			> /home/pit116/B_ICC2018_priliminary_grad_cell_based/third_version_15_state/SYN/report_130_gating/timing.rpt

exit
#Read All Files
read_file -format sverilog ../RTL/TPA.sv
current_design TPA
link

#Setting Clock Constraints
source -echo -verbose TPA.sdc

#Synthesis all design
compile -map_effort high -area_effort high
compile -map_effort high -area_effort high -inc

write -format ddc     -hierarchy -output "./report/TPA_syn.ddc"
write_sdf ./netlist/TPA_syn.sdf
write_file -format verilog -hierarchy -output ./netlist/TPA_syn.v
report_area > ./report/area.rpt
report_timing > ./report/timing.rpt
report_qor   >  ./report/TPA_syn.qor


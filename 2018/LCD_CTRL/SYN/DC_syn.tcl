#Read All Files
read_file -format sverilog ../RTL/LCD_CTRL.sv
current_design LCD_CTRL
link

#Setting Clock Constraints
source -echo -verbose LCD_CTRL.sdc

#Synthesis all design
compile -map_effort high -area_effort high
compile -map_effort high -area_effort high -inc

write -format ddc     -hierarchy -output "./report/LCD_CTRL_syn.ddc"
write_sdf ./netlist/LCD_CTRL_syn.sdf
write_file -format verilog -hierarchy -output ./netlist/LCD_CTRL_syn.v
report_area > ./report/area.log
report_timing > ./report/timing.log
report_qor   >  ./report/LCD_CTRL_syn.qor


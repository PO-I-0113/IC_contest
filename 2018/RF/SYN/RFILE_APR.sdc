# operating conditions and boundary conditions #
#et cycle 20 ;#Modify period by yourself
set cycle $CONSTRAIN ;#Modify period by yourself
create_clock -name clk  -period $cycle   [get_ports  clk]   ;


set_clock_uncertainty  0.1  [all_clocks]
set_clock_latency      1.0  [all_clocks]
#Don't touch the basic env setting as below
set_input_delay  -max [expr $cycle / 10.0]   -clock clk [get_ports value*]   ;
set_input_delay  -min 0.0                    -clock clk [get_ports value*]   ;
set_output_delay -max [expr $cycle / 10.0]   -clock clk [get_ports exp*]     ;
set_output_delay -min 0.0                    -clock clk [get_ports exp*]     ;

set_input_delay  -max [expr $cycle / 10.0]   -clock clk [remove_from_collection [all_inputs]  [get_ports {clk value*}]]  
set_input_delay  -min 0.0                    -clock clk [remove_from_collection [all_inputs]  [get_ports {clk value*}]] 

set_output_delay -max [expr $cycle / 10.0]   -clock clk [remove_from_collection [all_outputs] [get_ports exp*]]
set_output_delay -min 0.0                    -clock clk [remove_from_collection [all_outputs] [get_ports exp*]]

set_load         0.01  [all_outputs]
set_drive        0.1   [all_inputs]

# TSMC13
set_operating_conditions -max slow -min fast
# ADFP
#set_operating_conditions -library N16ADFP_StdCellff0p88v125c_ccs
#set_wire_load_model -name ZeroWireload -library N16ADFP_StdCellff0p88v125c_ccs  

set_max_fanout 6 [all_inputs]


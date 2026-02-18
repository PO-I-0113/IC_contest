# operating conditions and boundary conditions #


#set cycle $env(VAR_CLK_PERIOD) ;#Modify period by yourself
set cycle $CONSTRAIN
#set cycle 10
create_clock -name clk  -period $cycle   [get_ports  clk]   ;


set_dont_touch_network      [all_clocks]
set_fix_hold                [all_clocks]
# TSMC13
set_clock_uncertainty  0.1  [all_clocks]
# ADFP
#set_clock_uncertainty  -setup 0.1            [all_clocks]
#set_clock_uncertainty  -hold  0.05           [all_clocks]

set_clock_latency      0.5  [all_clocks]
set_ideal_network           [get_ports clk]


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
#set_operating_conditions  -max slow  -min fast      
#set_wire_load_model -name tsmc13_wl10 -library slow      
set_operating_conditions -max_library slow -max slow
#set_wire_load_model -name tsmc13_wl10 -library slow  
# ADFP
#set_operating_conditions -library N16ADFP_StdCellff0p88v125c_ccs
#set_wire_load_model -name ZeroWireload -library N16ADFP_StdCellff0p88v125c_ccs   


#set_operating_conditions -library N16ADFP_StdCellss0p72vm40c_ccs
#set_wire_load_model -name ZeroWireload -library N16ADFP_StdCellss0p72vm40c_ccs

set_max_fanout 6 [all_inputs]



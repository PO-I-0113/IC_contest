# ============================================================
# SDC 模板 — DESIGN_TOP
# ============================================================

set CLK_PERIOD 10.0

create_clock -name clk -period $CLK_PERIOD [get_ports clk]

set_input_delay  [expr $CLK_PERIOD * 0.3] -clock clk [all_inputs]
set_output_delay [expr $CLK_PERIOD * 0.3] -clock clk [all_outputs]

# set_load 0.05 [all_outputs]
# set_max_fanout 20 [current_design]

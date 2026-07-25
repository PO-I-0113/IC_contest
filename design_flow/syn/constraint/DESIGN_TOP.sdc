# ============================================================
# 競賽常見 SDC 模板（單一時脈 clk + 非同步 rst）
# 路徑：syn/constraint/DESIGN_TOP.sdc
# 週期單位與庫一致（通常 ns）
# ============================================================

# 時脈週期（依題目 / 時序目標調整）
set cycle 10.0

# 建立時脈
create_clock -name clk -period $cycle [get_ports clk]

# 時脈網路理想化（pre-layout / 競賽常見寫法）
set_dont_touch_network [get_clocks clk]
set_ideal_network      [get_ports  clk]

# Reset 當理想網路（非同步 rst 常見作法）
set_dont_touch_network [get_ports rst]
set_ideal_network      [get_ports rst]
set_false_path -from   [get_ports rst]

# Drive / Load（無 SPEF 時的簡單模型）
set_drive 0.1  [all_inputs]
set_load  0.05 [all_outputs]

# I/O delay：競賽常見設為半週期；clk 本身不設 input delay
set io_delay [expr $cycle * 0.5]
set_input_delay  $io_delay -clock clk [remove_from_collection [all_inputs]  [get_ports {clk rst}]]
set_output_delay $io_delay -clock clk [all_outputs]

# 可選：扇出 / transition 限制
# set_max_fanout     20   [current_design]
# set_max_transition 0.5  [current_design]

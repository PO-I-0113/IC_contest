current_design [get_designs $TOPLEVEL]
remove_unconnected_ports -blast_buses [get_cells -hierarchical *]

#=================================================
#                Netlist-related
#=================================================
write -format ddc     -hierarchy -output ./$NET_DIR/${TOPLEVEL}_syn.ddc
write -format verilog -hierarchy -output ./$NET_DIR/${TOPLEVEL}_syn.v
write_sdf -version 2.1  -context verilog -load_delay net ./$NET_DIR/${TOPLEVEL}_syn.sdf
write_sdc -version 1.5 ./$NET_DIR/${TOPLEVEL}_syn.sdc

#=================================================
#                Syntheis result
#=================================================
# ===== Timing  =====
report_timing -sign 4  > ./$RPT_DIR/report_timing.rpt
report_timing -sign 4 -delay_type min > ./$RPT_DIR/report_hold_time.rpt

# ===== Area  =====
report_area -hier  > ./$RPT_DIR/report_area.rpt

# ===== Power  =====
report_power > ./$RPT_DIR/report_power.rpt

# ===== DFT  =====
dft_drc -coverage_estimate > ./$DFT_DIR/report_dFT_drc.rpt
dft_drc -verbose > ./$DFT_DIR/report_dFT_cell_drc.rpt
report_scan_path -view existing -chain all > ./$DFT_DIR/${TOPLEVEL}_path.rpt
report_scan_path -view existing -cell all > ./$DFT_DIR/${TOPLEVEL}_cell.rpt
write_test_protocol -output ./$DFT_DIR/${TOPLEVEL}.spf  
write_scan_def -output ./$DFT_DIR/${TOPLEVEL}.def

set_svf ./$DFT_DIR/${TOPLEVEL}_dft.svf

exit
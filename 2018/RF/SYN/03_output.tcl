# ============================================================================
# 清理未連接的端口
# ============================================================================
current_design [get_designs $TOPLEVEL]
remove_unconnected_ports -blast_buses [get_cells -hierarchical *]

# ============================================================================
# 輸出網表文件
# ============================================================================
write -format ddc     -hierarchy -output ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$DFT_NET_DIR/${TOPLEVEL}_syn.ddc
write -format verilog -hierarchy -output ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$DFT_NET_DIR/${TOPLEVEL}_syn.v
write_sdf -version 2.1  -context verilog -load_delay net ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$DFT_NET_DIR/${TOPLEVEL}_syn.sdf
write_sdc -version 2.1 ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$DFT_NET_DIR/${TOPLEVEL}_syn.sdc

# ============================================================================
# 綜合結果報告
# ============================================================================
# ===== Timing  =====
report_timing -sign 4  > ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$RPT_DIR/report_timing.rpt 
report_timing -sign 4 -delay_type min > ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$RPT_DIR/report_hold_time.rpt

# ===== Area  =====
report_area -hier  > ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$RPT_DIR/report_area.rpt

# ===== Power  =====
report_power > ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$RPT_DIR/report_power.rpt

# ===== QOR 報告（整合自 dc_syn_pipe.tcl） =====
report_qor   >  ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$RPT_DIR/${TOPLEVEL}_syn.qor

# ============================================================================
# DFT 相關報告
# ============================================================================
dft_drc -coverage_estimate > ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$DFT_RPT_DIR/report_dFT_drc.rpt
dft_drc -verbose > ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$DFT_RPT_DIR/report_dFT_cell_drc.rpt
report_scan_path -view existing -chain all > ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$DFT_RPT_DIR/${TOPLEVEL}_path.rpt
report_scan_path -view existing -cell all > ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$DFT_RPT_DIR/${TOPLEVEL}_cell.rpt
write_test_protocol -output ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$DFT_RPT_DIR/${TOPLEVEL}.spf  
write_scan_def -output ./$VERSION/$SCAN/$TECH/clk_$CONSTRAIN/$DFT_RPT_DIR/${TOPLEVEL}.def

exit
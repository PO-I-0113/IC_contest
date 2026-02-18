#PrimeTime Script
read_file -format verilog /home/pit116/U18_chip/huffman/innovus_file/huffman_netlist.v
current_design huffman
link
read_sdf /home/pit116/U18_chip/huffman/innovus_file/huffman_netlist.sdf
read_sdc /home/pit116/U18_chip/huffman/SYN/dft_netlist/huffman_syn.sdc
###env. setup###

set si_enable_analysis true
set si_xtalk_double_swiching_mode clock_network
set power_enable_analysis true
set power_enable_multi_rail_analysis true
set power_analysis_mode time_based
update_timing -full
check_timing -verbose
report_annotated_parasitics -check

################

## Measure  power

read_vcd  /home/pit116/U18_chip/huffman/SIM/huffman_LAYOUT.vcd -strip_path tb/u_huffman
set_power_analysis_options -waveform_format fsdb -waveform_output power_U18.fsdb
update_power
report_power 
report_power > design.power



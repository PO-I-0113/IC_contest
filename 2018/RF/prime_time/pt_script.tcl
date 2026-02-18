#PrimeTime Script
set power_enable_analysis TRUE
set power_analysis_mode time_based
#total two mode averaged and time_based
#default is averaged
#set VERSION pipeline_nongeneral_version
#set CONSTRAIN 10
read_file -format verilog  /home/SOC/M143110005/EF/B_ICC2018_grad_cell-based/SYN/pipeline_signed_final_version_div/scan_chain/TSMC13/clk_20/netlist/RFILE_syn.v
current_design RFILE
link

source ../SYN/RFILE_APR.sdc
#read_parasitics -format SPEF -verbose  ./RFILE_pr.spef

## Measure  power
#read_saif  -strip_path test/u_RFILE /home/SOC/M143110005/EF/B_ICC2018_grad_cell-based/SIM/RFILE_power.saif 
read_vcd  -strip_path test/u_RFILE  /home/SOC/M143110005/EF/B_ICC2018_grad_cell-based/SIM/RFILE_test_power.vcd
#report_switching_activity -list_not_annotated -show_pin

update_power

report_power




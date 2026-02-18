read_netlist /mnt2/CBDK_UMC_180nm_Faraday_v1.1/orig_lib/fsa0m_a/2009Q2v2.0/GENERIC_CORE/FrontEnd/tetramax/fsa0m_a_generic_core_tmax.lib
read_netlist /mnt2/CBDK_UMC_180nm_Faraday_v1.1/orig_lib/fsa0m_a/2008Q3v1.2/T33_GENERIC_IO/FrontEnd/tetramax/fsa0m_a_t33_generic_io_tmax.lib
read_netlist /home/pit116/U18_chip/huffman/SYN/dft_netlist/huffman_syn.v
run_build_model huffman
set_drc /home/pit116/U18_chip/huffman/SYN/dft_report/huffman.spf
run_drc

#set_faults -fault_coverage -summary verbose
set_faults -fault_coverage 
#set_atpg -num_processes 2
set_atpg -abort 100000
#Basic-Scan
run_atpg -auto

#Fast-Sequential 
#capture cycles:3 for runtime;10 for coverage
#set_patterns  -histogram_summary
#set_atpg  -capture_cycles 3    
#run_atpg -auto

#Full-Sequential
#run_atpg  -auto full_sequential_only

report_summaries > ./atpg.log
write_fault ./fault_all.log -all
write_patterns ./pattern.stil -internal -format stil
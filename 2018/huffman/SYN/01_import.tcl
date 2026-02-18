set TOPLEVEL huffman
set RPT_DIR report
set NET_DIR dft_netlist
set HDL_DIR RTL
set DFT_DIR dft_report
set AUTO_DIR auto_data


sh rm -rf ./$RPT_DIR
sh rm -rf ./$NET_DIR
sh rm -rf ./$DFT_DIR
sh mkdir  ./$RPT_DIR
sh mkdir  ./$NET_DIR
sh mkdir  ./$DFT_DIR
set_host_options -max_cores 16
set_svf ${TOPLEVEL}_dft.svf

# Read Design File 
read_file -format verilog ../$HDL_DIR/${TOPLEVEL}.v

# link the design
current_design $TOPLEVEL
link

source -echo -verbose ./${TOPLEVEL}.sdc
# ============================================================
# Cadence Innovus APR
# 輸入串接：syn/netlist/${TOP}_syn.v + syn SDC
# 執行：cd apr/script && innovus -file run_innovus.tcl
# 路徑：一律相對 design_flow/
# ============================================================

cd ../..
source common/scripts/setup.tcl

file mkdir [file dirname $APR_DEF]
file mkdir [file dirname $APR_GDS]
file mkdir $APR_REPORT
file mkdir apr/lef
file mkdir apr/lib

if {![file exists $SYN_NETLIST]} {
    puts "ERROR: 找不到合成網表: $SYN_NETLIST"
    puts "ERROR: 請先執行 make syn CLK=$CLK"
    exit 1
}

# ---------- 設計 / Library（相對路徑；請自行放入 lef/lib）----------
set init_design_netlisttype Verilog
set init_verilog $SYN_NETLIST
set init_top_cell $TOP

# SDC：優先 SYN 輸出，其次 constraint
if {[file exists $SYN_SDC_OUT]} {
    set init_timing_file $SYN_SDC_OUT
} else {
    set init_timing_file $SYN_SDC
}

# 請把製程 lef / lib 放到相對路徑後取消註解
# set init_lef_file [list apr/lef/tech.lef apr/lef/stdcell.lef]
# set init_mmmc_file apr/script/mmmc.tcl

# 若尚未準備 tech 檔，以下流程會失敗；先保留完整骨架
if {![file exists apr/lef/tech.lef]} {
    puts "WARN: 尚未放置 apr/lef/tech.lef"
    puts "WARN: 請放入 lef/lib 並設定 init_lef_file / mmmc 後再跑完整 APR"
}

init_design
setDesignMode -process 45

# ---------- Floorplan（競賽常見手動框大小，可再調）----------
floorPlan -site core -r 1.0 0.7 20 20 20 20
# create_place_blockage / place macro ... 依設計補

# ---------- Place ----------
setPlaceMode -fp false
place_design
checkPlace > $APR_REPORT/check_place.rpt

# ---------- CTS ----------
set_ccopt_mode -integrate_clock_gating true
ccopt_design
report_timing -max_paths 20 > $APR_REPORT/cts_timing.rpt

# ---------- Route ----------
setNanoRouteMode -quiet
routeDesign -globalDetail
verify_drc -report $APR_REPORT/drc.rpt

# ---------- Output（串接回 PT：可再抽 SPEF）----------
defOut -floorplan -netlist -routing $APR_DEF
streamOut $APR_GDS -mapFile $LIB_TECH/stream.map -libName DesignLib -merge { } -units 2000 -mode ALL

# 抽出 SPEF 供 PrimeTime post-layout（相對路徑）
# extractRC
# rcOut -spef $PT_SPEF

saveDesign apr/report/${TOP}_routed.enc
report_timing -max_paths 50 > $APR_REPORT/route_timing.rpt
summaryReport -nohtml -outfile $APR_REPORT/summary.rpt

puts "INFO: Innovus APR done."
puts "INFO: DEF = $APR_DEF"
puts "INFO: GDS = $APR_GDS"
exit

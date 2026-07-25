# ============================================================
# PrimeTime STA（單一路徑本，由 Makefile 傳 NET_TAG）
#   make pt      → NET_TAG=syn
#   make pt_dft  → NET_TAG=dft
# ============================================================

cd ../..
source common/scripts/setup.tcl

set TECH_TOOL "pt"
source common/scripts/load_tech.tcl

file mkdir $PT_REPORT
file mkdir primetime/constraint
file mkdir [file dirname $PT_SPEF]

if {![file exists $ACTIVE_NETLIST]} {
    puts "ERROR: 找不到網表: $ACTIVE_NETLIST"
    if {$NET_TAG eq "dft"} {
        puts "ERROR: 請先 make syn_dft TECH=$TECH CLK=$CLK"
    } else {
        puts "ERROR: 請先 make syn TECH=$TECH CLK=$CLK"
    }
    exit 1
}

puts "INFO: PT NET_TAG=$NET_TAG → $ACTIVE_NETLIST"

read_verilog $ACTIVE_NETLIST
link_design $TOP
current_design $TOP

if {[file exists $ACTIVE_SDC_OUT]} {
    puts "INFO: source $ACTIVE_SDC_OUT"
    source $ACTIVE_SDC_OUT
} elseif {[file exists $SYN_SDC]} {
    puts "INFO: source $SYN_SDC"
    source $SYN_SDC
} else {
    puts "ERROR: 找不到 SDC"
    exit 1
}

if {$NET_TAG eq "dft"} {
    foreach p $SCAN_EN_PORTS {
        if {[sizeof_collection [get_ports $p -quiet]] > 0} {
            set_case_analysis 0 [get_ports $p]
            puts "INFO: set_case_analysis 0 \[get_ports $p\]"
        }
    }
    foreach p $TEST_MODE_PORTS {
        if {[sizeof_collection [get_ports $p -quiet]] > 0} {
            set_case_analysis 0 [get_ports $p]
            puts "INFO: set_case_analysis 0 \[get_ports $p\]"
        }
    }
}

if {[file exists $PT_SPEF]} {
    puts "INFO: read_parasitics $PT_SPEF"
    read_parasitics $PT_SPEF
} else {
    puts "INFO: 無 SPEF，進行 pre-layout STA"
}

update_timing

report_timing -delay_type max -max_paths 50 > $PT_REPORT/timing_max.rpt
report_timing -delay_type min -max_paths 50 > $PT_REPORT/timing_min.rpt
report_constraint -all_violators            > $PT_REPORT/violators.rpt
report_clock                                > $PT_REPORT/clock.rpt
report_qor                                  > $PT_REPORT/qor.rpt
report_global_timing                        > $PT_REPORT/global_timing.rpt

puts "INFO: PrimeTime done. NET_TAG=$NET_TAG"
puts "INFO: report = $PT_REPORT"
exit

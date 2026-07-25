# ============================================================
# PrimeTime STA
# SCAN=0 → *_syn.v ；SCAN=1 → *_syn_dft.v
# 執行：make pt CLK=10 SCAN=0
#       make pt CLK=10 SCAN=1
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
    if {$SCAN == 1} {
        puts "ERROR: SCAN=1，請先 make syn_dft TECH=$TECH CLK=$CLK"
    } else {
        puts "ERROR: SCAN=0，請先 make syn TECH=$TECH CLK=$CLK"
    }
    exit 1
}

puts "INFO: PT 使用網表 SCAN=$SCAN → $ACTIVE_NETLIST"

# ---------- Design ----------
read_verilog $ACTIVE_NETLIST
link_design $TOP
current_design $TOP

# SDC：優先對應網表輸出的 SDC
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

# SCAN=1 時可選：將 scan_en 設為功能模式，避免測試路徑干擾功能 STA
if {$SCAN == 1} {
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

# ---------- Reports ----------
report_timing -delay_type max -max_paths 50 > $PT_REPORT/timing_max.rpt
report_timing -delay_type min -max_paths 50 > $PT_REPORT/timing_min.rpt
report_constraint -all_violators            > $PT_REPORT/violators.rpt
report_clock                                > $PT_REPORT/clock.rpt
report_qor                                  > $PT_REPORT/qor.rpt
report_global_timing                        > $PT_REPORT/global_timing.rpt

puts "INFO: PrimeTime done. SCAN=$SCAN NET_TAG=$NET_TAG"
puts "INFO: netlist = $ACTIVE_NETLIST"
puts "INFO: report  = $PT_REPORT"
exit

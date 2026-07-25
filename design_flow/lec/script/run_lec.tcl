# ============================================================
# Formality LEC（單一路徑本，由 Makefile 傳 NET_TAG）
#   make lec      → NET_TAG=syn  → *_syn.v
#   make lec_dft  → NET_TAG=dft  → *_syn_dft.v
# ============================================================

cd ../..
source common/scripts/setup.tcl

set TECH_TOOL "fm"
source common/scripts/load_tech.tcl

file mkdir $LEC_REPORT
file mkdir [file dirname $LEC_SESSION]

if {![file exists $ACTIVE_NETLIST]} {
    puts "ERROR: 找不到網表: $ACTIVE_NETLIST"
    if {$NET_TAG eq "dft"} {
        puts "ERROR: 請先 make syn_dft TECH=$TECH CLK=$CLK"
    } else {
        puts "ERROR: 請先 make syn TECH=$TECH CLK=$CLK"
    }
    exit 1
}

set SVF_FILE $ACTIVE_SVF
if {![file exists $SVF_FILE] && $NET_TAG eq "dft"} {
    set SVF_FILE "$SYN_REPORT/${TOP}.svf"
}
if {[file exists $SVF_FILE]} {
    set_svf $SVF_FILE
    puts "INFO: set_svf $SVF_FILE"
} else {
    puts "WARN: 找不到 SVF，仍繼續 LEC"
}

read_sverilog -container r -libname WORK -12 $RTL_DIR/${TOP}.v
set_top r:/WORK/$TOP

read_verilog -container i -libname WORK $ACTIVE_NETLIST
set_top i:/WORK/$TOP

# ---------- DFT：固定 scan/test port 為功能模式 ----------
proc lec_try_set_constant {ref value} {
    if {[catch {set_constant -type port $ref $value -reapply} err]} {
        if {[catch {set_constant $ref $value} err2]} {
            return 0
        }
    }
    puts "INFO: set_constant $ref = $value"
    return 1
}

proc lec_apply_port_constants {container port_list value} {
    global TOP
    foreach p $port_list {
        set ref "${container}:/WORK/${TOP}/${p}"
        lec_try_set_constant $ref $value
    }
}

if {$NET_TAG eq "dft"} {
    puts "INFO: NET_TAG=dft → DFT LEC（固定 test/scan port）"
    lec_apply_port_constants "i" $SCAN_EN_PORTS 0
    lec_apply_port_constants "i" $TEST_MODE_PORTS 0
    lec_apply_port_constants "r" $SCAN_EN_PORTS 0
    lec_apply_port_constants "r" $TEST_MODE_PORTS 0
    catch {report_constants > $LEC_REPORT/constants.rpt}
} else {
    puts "INFO: NET_TAG=syn → 一般 syn netlist LEC"
}

match
verify

report_passing_points   > $LEC_REPORT/passing.rpt
report_failing_points   > $LEC_REPORT/failing.rpt
report_aborted_points   > $LEC_REPORT/aborted.rpt
report_unmatched_points > $LEC_REPORT/unmatched.rpt
report_status           > $LEC_REPORT/status.rpt

save_session $LEC_SESSION

puts "INFO: LEC done. NET_TAG=$NET_TAG"
puts "INFO: netlist = $ACTIVE_NETLIST"
puts "INFO: report  = $LEC_REPORT"
exit

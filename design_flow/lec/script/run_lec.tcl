# ============================================================
# Formality LEC
# Golden  : RTL
# Revised : SCAN=0 → *_syn.v ；SCAN=1 → *_syn_dft.v
# 執行：make lec CLK=10 SCAN=0
#       make lec CLK=10 SCAN=1
# ============================================================

cd ../..
source common/scripts/setup.tcl

set TECH_TOOL "fm"
source common/scripts/load_tech.tcl

file mkdir $LEC_REPORT
file mkdir [file dirname $LEC_SESSION]

if {![file exists $ACTIVE_NETLIST]} {
    puts "ERROR: 找不到網表: $ACTIVE_NETLIST"
    if {$SCAN == 1} {
        puts "ERROR: SCAN=1，請先 make syn_dft TECH=$TECH CLK=$CLK"
    } else {
        puts "ERROR: SCAN=0，請先 make syn TECH=$TECH CLK=$CLK"
    }
    exit 1
}

# SVF：DFT 優先 *_dft.svf，否則一般 svf
set SVF_FILE $ACTIVE_SVF
if {![file exists $SVF_FILE] && $SCAN == 1} {
    set SVF_FILE "$SYN_REPORT/${TOP}.svf"
}
if {[file exists $SVF_FILE]} {
    set_svf $SVF_FILE
    puts "INFO: set_svf $SVF_FILE"
} else {
    puts "WARN: 找不到 SVF，仍繼續 LEC"
}

# ---------- Golden (RTL) ----------
read_sverilog -container r -libname WORK -12 $RTL_DIR/${TOP}.v
set_top r:/WORK/$TOP

# ---------- Revised (netlist) ----------
read_verilog -container i -libname WORK $ACTIVE_NETLIST
set_top i:/WORK/$TOP

# ============================================================
# SCAN=1：DFT / scan chain 處理
# 功能等價比對時，將 scan enable / test mode 固定為功能模式
# ============================================================
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
        # 先嘗試直接設；失敗則略過（port 可能不存在）
        if {[lec_try_set_constant $ref $value]} {
            continue
        }
    }
}

if {$SCAN == 1} {
    puts "INFO: SCAN=1 → DFT LEC mode（固定 test/scan port 為功能模式）"

    # revised（gate）側：scan_en / SE = 0（功能模式）
    lec_apply_port_constants "i" $SCAN_EN_PORTS 0
    # test_mode = 0
    lec_apply_port_constants "i" $TEST_MODE_PORTS 0
    # golden 若也有同名 port，一併固定
    lec_apply_port_constants "r" $SCAN_EN_PORTS 0
    lec_apply_port_constants "r" $TEST_MODE_PORTS 0

    # 可選：忽略 scan 專用 PI/PO 名稱（依 insert_dft 實際命名調整）
    # set_dont_verify_points -type port i:/WORK/$TOP/SI*
    # set_dont_verify_points -type port i:/WORK/$TOP/SO*

    report_constants > $LEC_REPORT/constants.rpt
} else {
    puts "INFO: SCAN=0 → 一般 syn netlist LEC"
}

# ---------- Match & Verify ----------
match
verify

# ---------- Reports ----------
report_passing_points   > $LEC_REPORT/passing.rpt
report_failing_points   > $LEC_REPORT/failing.rpt
report_aborted_points   > $LEC_REPORT/aborted.rpt
report_unmatched_points > $LEC_REPORT/unmatched.rpt
report_status           > $LEC_REPORT/status.rpt

save_session $LEC_SESSION

puts "INFO: LEC done. SCAN=$SCAN NET_TAG=$NET_TAG"
puts "INFO: netlist = $ACTIVE_NETLIST"
puts "INFO: report  = $LEC_REPORT"
exit

# ============================================================
# Formality LEC
# Golden  : RTL
# Revised : syn/netlist/${TOP}_syn.v（SYN 串接）
# 執行：cd lec/script && fm_shell -f run_lec.tcl
# ============================================================

cd ../..
source common/scripts/setup.tcl

# 載入製程 setup（與 syn 使用相同 TECH）
set TECH_TOOL "fm"
source common/scripts/load_tech.tcl

file mkdir lec/report
file mkdir lec/session

file mkdir $LEC_REPORT
file mkdir [file dirname $LEC_SESSION]

if {![file exists $SYN_NETLIST]} {
    puts "ERROR: 找不到合成網表: $SYN_NETLIST"
    puts "ERROR: 請先執行 make syn TECH=$TECH CLK=$CLK"
    exit 1
}

# 讀取 DC 產出的 SVF（相對路徑）；若無檔案則跳過
set SVF_FILE "$SYN_REPORT/${TOP}.svf"
if {[file exists $SVF_FILE]} {
    set_svf $SVF_FILE
} else {
    puts "WARN: 找不到 SVF: $SVF_FILE （仍繼續 LEC）"
}

# ---------- Golden (RTL) ----------
read_sverilog -container r -libname WORK -12 $RTL_DIR/${TOP}.v
set_top r:/WORK/$TOP

# ---------- Revised (Syn netlist) ----------
read_verilog -container i -libname WORK $SYN_NETLIST
set_top i:/WORK/$TOP

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

puts "INFO: LEC done. reports -> $LEC_REPORT"
exit

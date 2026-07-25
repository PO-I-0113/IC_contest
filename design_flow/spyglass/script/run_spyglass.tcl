# ============================================================
# SpyGlass — Lint + CDC
# 執行：cd spyglass/script && sg_shell -tcl run_spyglass.tcl
# 路徑：相對 design_flow/
# ============================================================

cd ../..
source common/scripts/setup.tcl

file mkdir spyglass/report
file mkdir spyglass/waiver

# 新專案（相對路徑工作目錄）
new_project ${TOP}_sg -projectwdir spyglass/report -force

# 讀取 RTL
set_option top $TOP
set_option enableSV yes
set_option incdir $INC_DIR

read_file -type verilog [list \
    $INC_DIR/defines.vh \
    $RTL_DIR/${TOP}.v \
]

# 若有 waiver，可在此載入（相對路徑）
# read_file -type awl $SG_WAIVER/${TOP}.awl

# 若有自訂 methodology/policy，取消下一行註解
# current_methodology $SG_POLICY

# ---------- Goal 1: Lint ----------
current_goal lint/lint_rtl -top $TOP
run_goal
capture_results -goal lint/lint_rtl -outdir $SG_REPORT/lint

# ---------- Goal 2: CDC ----------
current_goal cdc/cdc_verify_struct -top $TOP
run_goal
capture_results -goal cdc/cdc_verify_struct -outdir $SG_REPORT/cdc

# 彙整報告（指令名稱依 SpyGlass 版本可能不同，可再微調）
# write_report summary > $SG_REPORT/summary.rpt

save_project
close_project

puts "INFO: SpyGlass Lint+CDC done. reports -> $SG_REPORT"
exit

# ============================================================
# SpyGlass 執行模板（Lint / CDC）
# 請依環境修改 library、top、goal
# ============================================================

set TOP      "DESIGN_TOP"
set ROOT     [file normalize [file join [pwd] ../..]]
set RTL_LIST [file join $ROOT rtl filelist.f]
set RPT_DIR  [file join $ROOT spyglass report]

file mkdir $RPT_DIR

# 新專案
new_project ${TOP}_sg -force

# 讀取 RTL（依 SpyGlass 版本調整指令）
# read_file -type sourcelist $RTL_LIST
# set_option top $TOP
# set_option enableSV yes

# 常用 goal 範例
# current_goal lint/lint_rtl -top $TOP
# run_goal
# current_goal cdc/cdc_verify_struct -top $TOP
# run_goal

# write_report 等指令請依版本補齊
puts "INFO: SpyGlass template loaded. TOP=$TOP"
puts "INFO: Edit spyglass/script/run_spyglass.tcl before running."

exit

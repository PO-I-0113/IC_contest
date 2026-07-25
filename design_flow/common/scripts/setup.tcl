# ============================================================
# 共用路徑設定（嚴格相對路徑）
# ------------------------------------------------------------
# 使用前提：
#   1. 由各階段 script 呼叫（Makefile 會先 cd 到 <stage>/script）
#   2. 呼叫端已執行：cd ../..
#      使目前工作目錄 = design_flow/
#   3. 再 source：source common/scripts/setup.tcl
#
# 所有路徑皆相對於 design_flow/，禁止寫死絕對路徑。
# Library 請用相對路徑放在 lib/，或自行改下方變數（仍請保持相對路徑）。
# ============================================================

if {![info exists TOP]} {
    set TOP "DESIGN_TOP"
}

# ---------- RTL / SIM ----------
set RTL_DIR     "rtl/src"
set INC_DIR     "rtl/include"
set FILELIST    "rtl/filelist.f"
set TB_DIR      "sim/tb"

# ---------- SpyGlass ----------
set SG_SCRIPT   "spyglass/script"
set SG_POLICY   "spyglass/policy"
set SG_WAIVER   "spyglass/waiver"
set SG_REPORT   "spyglass/report"

# ---------- SYN（DC 產出，供後段串接）----------
set SYN_SCRIPT  "syn/script"
set SYN_SDC     "syn/constraint/${TOP}.sdc"
set SYN_NETLIST "syn/netlist/${TOP}_syn.v"
set SYN_SDC_OUT "syn/netlist/${TOP}_syn.sdc"
set SYN_DDC     "syn/netlist/${TOP}_syn.ddc"
set SYN_REPORT  "syn/report"

# ---------- LEC ----------
set LEC_REPORT  "lec/report"
set LEC_SESSION "lec/session/${TOP}_lec.fss"

# ---------- TMAX ----------
set TMAX_REPORT  "tmax/report"
set TMAX_PATTERN "tmax/pattern/${TOP}_atpg.v"

# ---------- PrimeTime ----------
set PT_SCRIPT   "primetime/script"
set PT_SDC      "primetime/constraint/${TOP}.sdc"
set PT_SPEF     "primetime/spef/${TOP}.spef"
set PT_REPORT   "primetime/report"

# ---------- APR (Innovus) ----------
set APR_SCRIPT  "apr/script"
set APR_LIB     "apr/lib"
set APR_LEF     "apr/lef"
set APR_DEF     "apr/def/${TOP}.def"
set APR_GDS     "apr/gds/${TOP}.gds"
set APR_REPORT  "apr/report"

# ---------- 共用 Library（相對路徑；請自行放入或建立 symlink）----------
set LIB_STDCELL "lib/stdcell"
set LIB_MEMORY  "lib/memory"
set LIB_TECH    "lib/tech"

# 標準元件 db/lib 檔名（依你放入 lib/stdcell 的實際檔名修改）
set TARGET_LIB_FILE "${LIB_STDCELL}/slow.db"
set LINK_LIB_FILE   "${LIB_STDCELL}/slow.db"

puts "INFO: \[setup.tcl\] TOP=$TOP  (cwd=[pwd])"
puts "INFO: \[setup.tcl\] SYN_NETLIST=$SYN_NETLIST"
puts "INFO: \[setup.tcl\] SYN_SDC=$SYN_SDC"

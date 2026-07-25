# ============================================================
# ICC2 APR 模板（示意）
# ============================================================

set TOP  "DESIGN_TOP"
set ROOT [file normalize [file join [pwd] ../..]]

# create_lib ...
# read_verilog [file join $ROOT syn netlist ${TOP}_syn.v]
# read_sdc     [file join $ROOT syn constraint ${TOP}.sdc]
# # floorplan / place / cts / route ...
# write_gds [file join $ROOT apr gds ${TOP}.gds]
# write_def [file join $ROOT apr def ${TOP}.def]

puts "INFO: ICC2 template — fill in process tech & flow commands."
exit

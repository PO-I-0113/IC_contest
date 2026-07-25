# PrimeTime Constraint

本 flow **預設串接** `syn/netlist/${TOP}_syn.sdc`（或 `syn/constraint/${TOP}.sdc`）。

若要放 PT 專用 SDC，可放於此目錄，並修改 `primetime/script/run_pt.tcl` 的讀取順序。

請維持相對 `design_flow/` 的路徑。

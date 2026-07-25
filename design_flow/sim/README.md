# Simulation

## RTL

```bash
make sim SIM=vcs
```

## Gate-level（`sim_gate`）

需要：

1. 合成網表：`syn/netlist/clk_<CLK>/*_syn.v` 或 `*_syn_dft.v`
2. SDF：`syn/report/clk_<CLK>/*_syn.sdf`（建議）
3. 製程 verilog：`lib/<TECH>/stdcell/typical.v`

```bash
make sim_gate TECH=U18 CLK=10 SCAN=0
make sim_gate TECH=U18 CLK=10 SCAN=1
make sim_gate TECH=U18 CLK=10 SCAN=1 TIMING=0
```

| 變數 | 預設 | 說明 |
| :--- | :--- | :--- |
| `SCAN` | `0` | `0`→syn netlist；`1`→dft netlist |
| `GATE_NET` | （跟 SCAN） | 可強制 `syn` / `dft` / `auto` |
| `TIMING` | `1` | `0` 時加 `+notimingcheck` |
| `TECH_VERILOG` | `lib/<TECH>/stdcell/typical.v` | cell model |
| `SIM` | `vcs` | `vcs` / `xrun` / `ncverilog` |

Log：`sim/report/clk_<CLK>/syn|dft/sim_gate_*.log`

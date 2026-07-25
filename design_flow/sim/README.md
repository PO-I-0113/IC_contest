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
make sim_gate TECH=U18 CLK=10
make sim_gate TECH=U18 CLK=10 GATE_NET=dft
make sim_gate TECH=U18 CLK=10 GATE_NET=syn TIMING=0
```

| 變數 | 預設 | 說明 |
| :--- | :--- | :--- |
| `GATE_NET` | `auto` | `auto` / `syn` / `dft` |
| `TIMING` | `1` | `0` 時加 `+notimingcheck` |
| `TECH_VERILOG` | `lib/<TECH>/stdcell/typical.v` | cell model 相對路徑 |
| `SIM` | `vcs` | `vcs` / `xrun` / `ncverilog` |

Log：`sim/report/clk_<CLK>/sim_gate_<GATE_NET>.log`

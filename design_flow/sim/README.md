# Simulation

## RTL

```bash
make sim SIM=vcs
```

## Gate-level

```bash
make sim_gate      TECH=U18 CLK=10          # *_syn.v
make sim_gate_dft  TECH=U18 CLK=10          # *_syn_dft.v
make sim_gate      TECH=U18 CLK=10 TIMING=0 # +notimingcheck
```

| 變數 | 預設 | 說明 |
| :--- | :--- | :--- |
| `TIMING` | `1` | `0` 時加 `+notimingcheck` |
| `TECH_VERILOG` | `lib/<TECH>/stdcell/typical.v` | cell model |
| `SIM` | `vcs` | `vcs` / `xrun` / `ncverilog` |

Log：`sim/report/clk_<CLK>/syn|dft/sim_gate.log`

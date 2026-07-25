# LEC（Formality）

## SCAN 選擇

| 指令 | 網表 |
| :--- | :--- |
| `make lec SCAN=0 CLK=10` | `*_syn.v`（一般合成） |
| `make lec SCAN=1 CLK=10` | `*_syn_dft.v`（含 scan chain） |

報告：`lec/report/clk_<CLK>/syn/` 或 `.../dft/`

## SCAN=1 時的處理

比對 **RTL（功能）** vs **DFT netlist** 時，會嘗試將下列 port 固定為功能模式：

- scan enable：`scan_en` / `SE` / `se` / `test_se` → `0`
- test mode：`test_mode` / `tm` / `TEST_MODE` → `0`

可在呼叫時覆寫（TCL 變數）：

```bash
fm_shell -x 'set TOP DESIGN_TOP; set SCAN 1; set SCAN_EN_PORTS {my_se}; set TEST_MODE_PORTS {my_tm}' -f run_lec.tcl
```

若 insert_dft 產生的 port 名稱不同，請更新 `setup.tcl` 的 `SCAN_EN_PORTS` / `TEST_MODE_PORTS`。

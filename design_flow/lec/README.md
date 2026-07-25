# LEC（Formality）

## 指令

| 指令 | 網表 |
| :--- | :--- |
| `make lec CLK=10` | `*_syn.v` |
| `make lec_dft CLK=10` | `*_syn_dft.v` |

報告：`lec/report/clk_<CLK>/syn/` 或 `.../dft/`

腳本只有一支：`lec/script/run_lec.tcl`（由 Makefile 傳入 `NET_TAG`）。

## `lec_dft` 額外處理

固定 scan enable / test mode 為功能模式後再比對。  
port 名稱預設在 `common/scripts/setup.tcl` 的 `SCAN_EN_PORTS` / `TEST_MODE_PORTS`。

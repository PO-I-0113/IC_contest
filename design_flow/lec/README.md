# LEC（Formality）

本目錄用於 **邏輯等價檢查（Logic Equivalence Check）**。

## 用途
- 合成後：RTL vs `syn/netlist/*_syn.v`
- ECO 後：修改前 netlist vs 修改後 netlist

## 目錄
| 路徑 | 說明 |
| :--- | :--- |
| `script/run_lec.tcl` | Formality 主腳本 |
| `session/` | `.fss` session（debug 用） |
| `report/` | passing / failing / aborted 報告 |

## 執行
```bash
make lec
# 或
cd lec/script && fm_shell -f run_lec.tcl
```

## 通過標準（建議）
- Failing points = 0
- Aborted / not-compared 需有合理解釋或已清理

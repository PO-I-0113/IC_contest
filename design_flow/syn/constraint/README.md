# Constraint（SDC）

## 命名與 CLK 對應

| 檔名 | 使用時機 |
| :--- | :--- |
| `${TOP}_clk10.sdc` | `make syn CLK=10` 時優先 |
| `${TOP}_clk6.sdc` | `make syn CLK=6` 時優先 |
| `${TOP}.sdc` | 找不到對應 clk 檔時的預設 |

範例：

```bash
# 使用 syn/constraint/DESIGN_TOP_clk10.sdc（若存在）
make syn CLK=10

# 使用 syn/constraint/DESIGN_TOP_clk6.sdc（若存在）
make syn CLK=6
```

請讓 SDC 內的 `create_clock -period` 與資料夾 `clk_<數字>` 意義一致，方便辨識。

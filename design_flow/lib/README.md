# Library / 製程 Setup

## 支援製程

| TECH | 目錄 | 說明 |
| :--- | :--- | :--- |
| `U18` | `lib/U18/` | UMC 180nm 類（依實際 library 調整） |
| `TSMC13` | `lib/TSMC13/` | TSMC 130nm |
| `ADFP` | `lib/ADFP/` | ADFP（依實際 library 調整） |
| `TN16` | `lib/TN16/` | TSMC N16 / 16nm 類 |
| `TN7` | `lib/TN7/` | TSMC N7 / 7nm 類 |

每個製程目錄包含：

```text
lib/<TECH>/
├── setup_dc.tcl      # Design Compiler
├── setup_pt.tcl      # PrimeTime
├── setup_fm.tcl      # Formality
└── stdcell/          # .db / .sdb / typical.v（相對路徑或 symlink）
```

Gate-level 模擬需要 cell verilog model，預設讀：

```text
lib/<TECH>/stdcell/typical.v
```

可覆寫：`make sim_gate TECH_VERILOG=lib/U18/stdcell/slow.v`
## 怎麼選製程

```bash
make syn TECH=U18
make syn TECH=TSMC13
make syn TECH=ADFP
make syn TECH=TN16
make syn TECH=TN7
make pt  TECH=U18      # 請與合成相同 TECH
```

預設：`TECH=U18`

## 新增製程

1. 建立 `lib/<name>/`
2. 複製既有 `setup_dc.tcl` / `setup_pt.tcl` / `setup_fm.tcl`
3. 改 db 檔名（維持相對 `design_flow/` 路徑）
4. library 放到 `lib/<name>/stdcell/`
5. `make syn TECH=<name>`

## 路徑原則

- 只使用相對路徑（例如 `lib/U18/stdcell/slow.db`）
- 不要寫絕對路徑；若 library 在工作站固定位置，請用 symlink 指到 `stdcell/`

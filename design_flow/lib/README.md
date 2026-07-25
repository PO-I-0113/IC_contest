# Library / 製程 Setup

## 目錄慣例

```text
lib/
├── tsmc18/
│   ├── setup_dc.tcl      # Design Compiler
│   ├── setup_pt.tcl      # PrimeTime
│   ├── setup_fm.tcl      # Formality
│   └── stdcell/          # 放置該製程 .db / .sdb（相對路徑）
├── tsmc90/
├── tsmc13/
├── memory/               # 可選：記憶體 model
└── tech/                 # 可選：共用 tech 檔
```

## 怎麼選製程

```bash
make syn TECH=tsmc18
make syn TECH=tsmc90
make pt  TECH=tsmc18    # 請與合成相同 TECH
```

預設：`TECH=tsmc18`（見根目錄 Makefile）

## 新增一個製程

1. 建立目錄：`lib/mytech/`
2. 複製任一套 `setup_dc.tcl` / `setup_pt.tcl` / `setup_fm.tcl`
3. 改成你的 db 檔名（維持相對 `design_flow/` 路徑）
4. 把 library 放到 `lib/mytech/stdcell/`（或 symlink）
5. 執行：`make syn TECH=mytech`

## 路徑原則

- **只使用相對路徑**（例如 `lib/tsmc18/stdcell/slow.db`）
- 不要在 setup 裡寫 `/usr/cad/...` 絕對路徑
- 若 library 在工作站固定位置，請在 `lib/<TECH>/stdcell/` 做 symlink

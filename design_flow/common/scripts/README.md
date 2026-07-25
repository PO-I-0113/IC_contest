# common/scripts

## `setup.tcl`

集中定義 `TOP` 與各階段相對路徑。

### 使用方式（各 TCL 開頭固定這樣寫）

```tcl
cd ../..
source common/scripts/setup.tcl
```

前提：由 `design_flow/<stage>/script/` 啟動（Makefile 已這樣做）。

### 路徑原則

- 全部相對 `design_flow/`
- **不要**使用 `/home/...`、`/usr/cad/...` 等絕對路徑
- library 請放到 `lib/stdcell`（或改 `setup.tcl` 內相對路徑變數）

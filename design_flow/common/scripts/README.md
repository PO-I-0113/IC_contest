# common/scripts

## `setup.tcl`

集中定義 `TOP`、`TECH` 與各階段相對路徑（不含 library db 設定）。

## `load_tech.tcl`

依 `TECH` + `TECH_TOOL` 載入：

```text
lib/<TECH>/setup_<TECH_TOOL>.tcl
```

- `TECH_TOOL=dc` → `setup_dc.tcl`
- `TECH_TOOL=pt` → `setup_pt.tcl`
- `TECH_TOOL=fm` → `setup_fm.tcl`

### 使用方式

```tcl
cd ../..
source common/scripts/setup.tcl
set TECH_TOOL "dc"
source common/scripts/load_tech.tcl
```

Makefile 會透過 `-x 'set TOP ...; set TECH ...'` 傳入變數。

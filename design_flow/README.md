# IC Design Flow Template

數位 IC 設計完整流程骨架（方案 A：依工具／階段分層）。

涵蓋：**RTL → SIM → COV → SpyGlass → SYN → LEC → TMAX → PrimeTime → APR**

---

## 目錄結構

```text
design_flow/
├── doc/                 # 規格、架構、簽核 checklist
├── rtl/                 # RTL 原始碼
│   ├── include/         # header / define
│   └── src/             # 設計原始碼
├── sim/                 # 功能模擬
│   ├── tb/              # testbench
│   ├── pattern/         # 測試向量
│   └── script/          # 模擬腳本
├── cov/                 # Code Coverage
│   ├── script/
│   ├── config/
│   └── report/
├── spyglass/            # Lint / CDC / RDC
│   ├── script/
│   ├── policy/
│   ├── waiver/
│   └── report/
├── syn/                 # Design Compiler 合成
│   ├── script/          # run_syn.tcl / run_syn_dft.tcl
│   ├── constraint/      # SDC（可 ${TOP}_clk<CLK>.sdc）
│   ├── netlist/clk_*/   # 依時脈週期分層的網表
│   ├── report/clk_*/    # 一般合成報告
│   └── dft_report/clk_*/# DFT / scan 專用報告
├── lec/                 # Formality LEC（邏輯等價檢查）
│   ├── script/
│   ├── session/
│   └── report/
├── tmax/                # TetraMAX ATPG
│   ├── script/
│   ├── pattern/
│   └── report/
├── primetime/           # 靜態時序分析 (STA)
│   ├── script/
│   ├── constraint/
│   ├── spef/
│   └── report/
├── apr/                 # Auto Place & Route (ICC2 / Innovus)
│   ├── script/
│   ├── lib/
│   ├── lef/
│   ├── def/
│   ├── gds/
│   └── report/
├── lib/                 # 共用 library / memory / tech
│   ├── stdcell/
│   ├── memory/
│   └── tech/
├── common/scripts/      # 共用工具腳本
├── work/                # 執行暫存（不進 git）
├── Makefile
└── README.md
```

---

## 建議執行順序

| 順序 | 階段 | 目錄 | 工具 | 產出 |
| :--- | :--- | :--- | :--- | :--- |
| 1 | RTL | `rtl/` | 編輯器 | 可綜合 RTL |
| 2 | SIM | `sim/` | VCS / xrun | 功能驗證通過 |
| 3 | COV | `cov/` | VCS/xrun Coverage | coverage report |
| 4 | SpyGlass | `spyglass/` | SpyGlass | Lint / CDC clean |
| 5 | SYN | `syn/` | Design Compiler (`compile_ultra`) | gate netlist + SDC + SVF |
| 6 | LEC | `lec/` | Formality | RTL vs Netlist 等價 |
| 7 | TMAX | `tmax/` | TetraMAX | ATPG pattern |
| 8 | PT | `primetime/` | PrimeTime | STA report |
| 9 | APR | `apr/` | **Innovus** | DEF / GDS |

詳細簽核項目見：[`doc/flow_checklist.md`](doc/flow_checklist.md)

---

## 路徑規則（嚴格相對路徑）

- 所有 TCL / Makefile / filelist **只使用相對 `design_flow/` 的路徑**
- 各階段 script 開頭固定：

```tcl
cd ../..
source common/scripts/setup.tcl
set TECH_TOOL "dc"   ;# 或 pt / fm
source common/scripts/load_tech.tcl
```

- **禁止**寫死 `/home/...`、`/usr/cad/...` 等絕對路徑
- 製程 library setup 放在 `lib/<TECH>/setup_*.tcl`

### 製程切換（TECH）

```bash
make syn TECH=U18
make syn TECH=TSMC13
make syn TECH=ADFP
make syn TECH=TN16
make syn TECH=TN7
make pt  TECH=U18      # 請與 syn 使用同一 TECH
```

| TECH | Setup 目錄 |
| :--- | :--- |
| `U18`（預設） | `lib/U18/` |
| `TSMC13` | `lib/TSMC13/` |
| `ADFP` | `lib/ADFP/` |
| `TN16` | `lib/TN16/` |
| `TN7` | `lib/TN7/` |

詳見 [`lib/README.md`](lib/README.md)。

### Clock 分層（CLK）+ Scan 分層（SCAN）

```bash
make syn     CLK=10              # → *_syn.v
make syn_dft CLK=10 TECH=U18     # → *_syn_dft.v
make pt      CLK=10 SCAN=0       # 用一般 syn
make pt      CLK=10 SCAN=1       # 用 DFT/scan
make lec     CLK=10 SCAN=1
make sim_gate CLK=10 SCAN=1
make tmax    CLK=10 SCAN=1
make apr     CLK=10 SCAN=1
```

| 變數 | 意義 |
| :--- | :--- |
| `CLK=10` | 目錄 `clk_10/`，對應不同 clock constraint |
| `SCAN=0` | 後段讀 `*_syn.v`（無 scan） |
| `SCAN=1` | 後段讀 `*_syn_dft.v`（有 scan） |

產出範例：

```text
syn/netlist/clk_10/${TOP}_syn.v
syn/netlist/clk_10/${TOP}_syn_dft.v
primetime/report/clk_10/syn/     # SCAN=0
primetime/report/clk_10/dft/     # SCAN=1
lec/report/clk_10/dft/
```

### 串接關係

```text
make syn      → *_syn.v      → 後段 SCAN=0（lec/pt/sim_gate/apr）
make syn_dft  → *_syn_dft.v  → 後段 SCAN=1（lec/pt/sim_gate/tmax/apr）
```

---

## 快速開始

### 1. 放入你的設計

```bash
# RTL
cp your_design.v rtl/src/
cp your_defines.vh rtl/include/

# Testbench
cp your_tb.sv sim/tb/

# 時序約束
cp your_design.sdc syn/constraint/
```

### 2. 修改頂層名稱

同時改：

- `Makefile` 的 `TOP`
- `common/scripts/setup.tcl` 預設 `TOP`（若不用 make 傳入）
- `syn/constraint/${TOP}.sdc` 檔名

```makefile
TOP ?= YOUR_MODULE
```

### 3. 放入 library（相對路徑）

```bash
# 範例：U18 慢角 db（檔名需對應 lib/U18/setup_dc.tcl）
cp slow.db lib/U18/stdcell/
```

### 4. 依序執行（需工作站 EDA license）

```bash
cd design_flow
make help
make spyglass

# 路徑 A：無 scan
make syn      TECH=U18 CLK=10
make lec      TECH=U18 CLK=10 SCAN=0
make pt       TECH=U18 CLK=10 SCAN=0
make sim_gate TECH=U18 CLK=10 SCAN=0

# 路徑 B：有 scan
make syn_dft  TECH=U18 CLK=10
make lec      TECH=U18 CLK=10 SCAN=1
make pt       TECH=U18 CLK=10 SCAN=1
make sim_gate TECH=U18 CLK=10 SCAN=1
make tmax     TECH=U18 CLK=10 SCAN=1
make apr      TECH=U18 CLK=10 SCAN=1
```
> 實際 library / lef / mmmc 仍需依你學校或公司環境補齊；腳本已留相對路徑插槽。

---

## 各階段說明

### `rtl/` — 設計原始碼
- `src/`：模組 RTL（Verilog / SystemVerilog）
- `include/`：共用 `define`、參數 header

### `sim/` — 功能模擬
- 建議先通過全部 pattern，再進 coverage / lint

### `cov/` — Code Coverage
- Line / Toggle / FSM / Conditional coverage
- 目標與 exclusion 放在 `cov/config/`

### `spyglass/` — 靜態檢查
- 預設跑 **Lint + CDC**
- waiver 統一放 `spyglass/waiver/`

### `syn/` — 合成
- `make syn`：`compile_ultra`（無 scan）
- `make syn_dft`：`compile_ultra -scan` + `insert_dft`（scan chain）
- 依 `CLK` 分層：`netlist/clk_*`、`report/clk_*`、`dft_report/clk_*`
- DFT 報告（scan path / dft_drc 等）只放 `dft_report/`

### `lec/` — Formality（邏輯等價）
- Golden：RTL／Revised：`syn/netlist/*_syn.v`
- 自動讀取 `syn/report/*.svf`（若存在）

### `tmax/` — DFT / ATPG
- 讀取合成網表做 stuck-at ATPG
- pattern → `tmax/pattern/`

### `primetime/` — STA
- 串接 syn netlist；優先 `syn/netlist/*_syn.sdc`
- 若有 `primetime/spef/*.spef` 則做 post-layout STA

### `apr/` — Innovus 佈局繞線
- 串接 syn netlist + SDC
- lef/lib 請放 `apr/lef`、`apr/lib`（相對路徑）
- 輸出：`apr/def`、`apr/gds`

---

## 環境假設

| 項目 | 建議 |
| :--- | :--- |
| OS | Linux（CentOS / RHEL / Ubuntu） |
| Simulator | Synopsys VCS 或 Cadence xrun |
| Lint/CDC | Synopsys SpyGlass |
| Synthesis | Synopsys Design Compiler |
| LEC | Synopsys Formality |
| ATPG | Synopsys TetraMAX |
| STA | Synopsys PrimeTime |
| APR | Synopsys ICC2 或 Cadence Innovus |

路徑與 library 請依你們公司／學校環境，修改各階段 `script/` 內的變數。

---

## 使用原則

1. **只把來源與腳本進 git**；report / netlist / work 預設忽略（可依需要調整 `.gitignore`）
2. **下一階段吃上一階段產出**（例如 LEC 讀 `syn/netlist/`）
3. **waiver / exclusion 必須可追溯**（寫原因、寫負責人）
4. 改 top 名稱時，同步改 `Makefile` 與各 tcl 的 `TOP` 變數

---

## License

Educational / personal IC design flow template.  
請自行確認 EDA 授權與製程 library 使用規範。

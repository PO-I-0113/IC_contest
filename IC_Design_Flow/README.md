# IC Design Flow Template

數位 IC 設計完整流程骨架（方案 A：依工具／階段分層）。

涵蓋：**RTL → SIM → COV → SpyGlass → SYN → LEC → TMAX → PrimeTime → APR**

---

## 目錄結構

```text
IC_Design_Flow/
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
│   ├── script/
│   ├── constraint/      # SDC
│   ├── netlist/         # 合成後網表
│   └── report/
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
| 5 | SYN | `syn/` | Design Compiler | gate netlist + SDC |
| 6 | LEC | `lec/` | Formality | RTL vs Netlist 等價 |
| 7 | TMAX | `tmax/` | TetraMAX | ATPG pattern |
| 8 | PT | `primetime/` | PrimeTime | STA report |
| 9 | APR | `apr/` | ICC2 / Innovus | DEF / GDS |

詳細簽核項目見：[`doc/flow_checklist.md`](doc/flow_checklist.md)

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

編輯 `Makefile` 頂部變數：

```makefile
TOP      ?= YOUR_MODULE
RTL_FILE ?= rtl/src/YOUR_MODULE.v
TB_FILE  ?= sim/tb/tb_YOUR_MODULE.sv
```

### 3. 依序執行（需本機已安裝對應 EDA）

```bash
make help          # 查看所有目標
make sim           # RTL 模擬
make cov           # Code Coverage
make spyglass      # Lint / CDC
make syn           # 合成
make lec           # Formality LEC
make tmax          # ATPG
make pt            # PrimeTime STA
make apr           # Place & Route
```

> **注意：** 本 repo 只提供目錄與腳本骨架。實際執行需在有 license 的工作站上操作。

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
- Lint、CDC、RDC
- waiver 統一放 `spyglass/waiver/`，避免散落

### `syn/` — 合成
- 輸入：`rtl/` + `syn/constraint/*.sdc`
- 輸出：`syn/netlist/*_syn.v`、report

### `lec/` — Formality（邏輯等價）
- 比對 **RTL（golden）** vs **Syn netlist（revised）**
- 合成後、ECO 後都應重跑
- session 檔可放 `lec/session/` 方便 debug

### `tmax/` — DFT / ATPG
- 依賴合成網表（與 DFT 插樁結果，依專案而定）
- pattern 產出放 `tmax/pattern/`

### `primetime/` — STA
- pre-layout：用 syn 後 netlist + SDC
- post-layout：加上 `primetime/spef/` 寄生參數

### `apr/` — 佈局繞線
- 輸入：netlist、SDC、lib、lef
- 輸出：def / gds、繞線後報告

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

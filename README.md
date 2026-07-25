# 🏆 Digital IC Design Contest Archive

![Status](https://img.shields.io/badge/Status-Maintained-success)
![Language](https://img.shields.io/badge/Language-Verilog%20%2F%20SystemVerilog-blue)
![Tools](https://img.shields.io/badge/Tools-Design%20Compiler%20%7C%20VCS%20%7C%20Verdi-orange)

## 📖 Overview

This repository documents my solutions for the **National Undergraduate/Graduate IC Design Contest (教育部 IC 設計競賽)**. It serves as a comprehensive record of my training in digital circuit design, RTL coding, and hardware optimization strategies.

Each project involves translating algorithmic specifications into synthesizable Verilog HDL, verifying functionality against testbenches, and optimizing for **Power, Performance, and Area (PPA)**.

## 🛠️ Tech Stack & Environment

* **RTL Design:** Verilog / SystemVerilog
* **Verification:** Cadence xrun / ncverilog / Synopsys VCS
* **Synthesis:** Synopsys Design Compiler (DC)
* **Static Timing Analysis:** Synopsys PrimeTime (PT)
* **ATPG:** Synopsys TetraMAX
* **Build System:** Makefile
* **Process Technology:** TSMC .18um / 90nm / 130nm (Based on contest specs)

## 🧭 IC Design Flow Template

完整 EDA flow 骨架見 [`IC_Design_Flow/`](IC_Design_Flow/)：

`rtl → sim → cov → spyglass → syn → lec → tmax → primetime → apr`

含 Makefile、簽核 checklist，以及各階段腳本模板（Formality 目錄命名為 `lec/`）。詳見該目錄 README。

## 📊 Solution Summary

> **Note:** Detailed architecture diagrams and synthesis reports can be found in each year's sub-directory.
>

### ✅ 已完成

| Year | Problem Name | Module Name | Category | RTL 路徑（主檔） |
| :--- | :--- | :--- | :--- | :--- |
| **2026** | Refraction（折射／光路） | `REFRACT` | Computational Optics | `2026/REFRACT/RTL/REFRACT.v` |
| **2024** | Bicubic Interpolation | `Bicubic` | Image Processing | `2024/bicubic/RTL/Bicubic.v`（含 `ImgROM`／`ResultSRAM`） |
| **2024** | HMC | `HMC` | Signal Processing | `2024/HMC/icc2024cb/RTL/HMC.sv` |
| **2020** | String Matching Engine | `SME` | String Processing | `2020/String_matching/RTL/SME.sv` |
| **2020** | SCE | `SCE` | Signal Processing | `2020/SCE/RTL/SCE.sv` |
| **2019** | Image Convolutional | `CONV` | Image Processing | `2019/Image_convolutional/RTL/CONV.sv` |
| **2019** | IoT Data Filter | `IOTDF` | Data Processing | `2019/IOTDF/RTL/IOTDF.v` |
| **2018** | Huffman Encoder | `huffman` | Data Compression | `2018/huffman/RTL/huffman.v` |
| **2018** | LCD Controller | `LCD_CTRL` | Display Control | `2018/LCD_CTRL/RTL/LCD_CTRL.sv` |
| **2018** | RF 定位（RSSI） | `RFILE` | Location Processing | `2018/RF/RTL/RFILE.v`（非暫存器檔） |
| **2018** | TPA | `TPA` | Signal Processing | `2018/TPA/RTL/TPA.sv` |

### ⏳ 未完成（頂層為空殼／尚無實作）

| Year | Problem Name | Module Name | Category | RTL 路徑（待補） |
| :--- | :--- | :--- | :--- | :--- |
| **2025** | CONVEX | `CONVEX` | Computational Geometry | `2025/CONVEX/CONVEX.v`（僅 port，`endmodule` 前無邏輯） |
| **2021** | Geofence | `geofence` | Location Processing | `2021/geofence/geofence.v`（僅 port） |
| **2019** | GPS Data Compression | `GPSDC` | Data Compression | `2019/GPSDC/RTL/GPSDC.v`（僅 port；TB／SDC 仍存在） |

## 📂 Directory Structure

```text
.
├── 2026/
│   └── REFRACT/              # ICC 2026 — Refraction / optics path
│       ├── RTL/              # RTL source files (REFRACT.v)
│       ├── SIM/              # Simulation testbenches
│       └── SYN/              # Synthesis scripts and reports
├── 2025/
│   └── CONVEX/               # CONVEX Algorithm
│       ├── CONVEX.v         # RTL source file
│       ├── tb.sv            # Testbench
│       ├── dc_syn.tcl       # Synthesis script
│       └── CONVEX.sdc       # Timing constraints
├── 2024/
│   ├── bicubic/              # Bicubic Interpolation
│   │   ├── RTL/              # RTL source files
│   │   ├── SIM/              # Simulation testbenches
│   │   ├── SYN/              # Synthesis scripts and reports
│   │   └── work/             # Build outputs and logs
│   └── HMC/                  # HMC Accelerator
│       └── icc2024cb/
│           ├── RTL/          # RTL source files
│           ├── SIM/          # Simulation testbenches
│           ├── SYN/          # Synthesis scripts and reports
│           ├── mem/          # Memory models
│           └── vcs/          # VCS simulation files
├── 2021/
│   └── geofence/             # Geofence Algorithm
│       ├── geofence.v        # RTL source file
│       ├── tb.sv             # Testbench
│       ├── dc_syn.tcl        # Synthesis script
│       └── geofence.sdc      # Timing constraints
├── 2020/
│   ├── String_matching/      # String Matching Engine (SME)
│   │   ├── RTL/              # RTL source files
│   │   ├── SIM/              # Simulation testbenches
│   │   └── SYN/              # Synthesis scripts and reports
│   └── SCE/                  # SCE Processor
│       ├── RTL/              # RTL source files
│       ├── SIM/              # Simulation testbenches
│       ├── SYN/              # Synthesis scripts and reports
│       ├── DFT/              # DFT/ATPG scripts
│       ├── prime_time/      # PrimeTime scripts
│       ├── work/             # Build outputs and logs
│       ├── sram_1024x12/     # SRAM memory models
│       ├── sram_8192x12/     # SRAM memory models
│       └── rom_32768x8/      # ROM memory models
├── 2019/
│   ├── GPSDC/                # GPS Data Compression
│   │   ├── GPSDC.v           # RTL source file
│   │   ├── testbench.v       # Testbench
│   │   └── GPSDC.sdc        # Timing constraints
│   ├── Image_convolutional/   # Image Convolutional Neural Network
│   │   ├── RTL/              # RTL source files (CONV.sv)
│   │   ├── SIM/              # Simulation testbenches
│   │   ├── SYN/              # Synthesis scripts and reports
│   │   ├── DFT/              # DFT/ATPG scripts
│   │   ├── prime_time/       # PrimeTime scripts
│   │   └── work/             # Build outputs and logs
│   └── IOTDF/                # IoT Data Filter
│       ├── RTL/              # RTL source files (IOTDF.v)
│       ├── SIM/              # Simulation testbenches
│       ├── SYN/              # Synthesis scripts and reports
│       ├── Prime_time/       # PrimeTime scripts
│       └── work/             # Build outputs and logs
├── 2018/
│   ├── huffman/             # Huffman Encoder
│   │   └── B_ICC2018_priliminary_grad_cell_based/
│   │       ├── RTL/          # RTL source files
│   │       ├── SIM/          # Simulation testbenches
│   │       └── SYN/          # Synthesis scripts and reports
│   ├── LCD_CTRL/             # LCD Controller
│   │   ├── RTL/              # RTL source files
│   │   ├── SIM/              # Simulation testbenches
│   │   ├── SYN/              # Synthesis scripts and reports
│   │   └── work/             # Build outputs and logs
│   ├── RF/                   # RF localization (RSSI), not register file
│   │   └── B_ICC2018_grad_cell-based/
│   │       ├── RTL/          # RTL source files (RFILE.v)
│   │       ├── SIM/          # Simulation testbenches
│   │       └── SYN/          # Synthesis scripts and reports
│   └── TPA/                  # TPA Signal Processor
│       ├── RTL/              # RTL source files
│       ├── SIM/              # Simulation testbenches
│       ├── SYN/              # Synthesis scripts and reports
│       ├── DFT/              # DFT/ATPG scripts
│       ├── prime_time/       # PrimeTime scripts
│       └── work/             # Build outputs and logs
├── IC_Design_Flow/           # 完整 EDA flow template（含 LEC）
├── Makefile                  # Root Makefile template
└── README.md
```

## 📝 Project Details

### 2026 Projects

#### Refraction (`REFRACT/`)
- **Module:** `REFRACT.v`
- **RTL 狀態：** ✅ 主模組含完整資料路徑與控制邏輯
- **Description:** 折射／光路相關運算硬體實作（依競賽題目規格）
- **Key Features:** SRAM 介面、狀態控制、折射幾何／數值運算資料路徑

### 2025 Projects

#### CONVEX (`CONVEX/`)
- **Module:** `CONVEX.v`
- **RTL 狀態：** ⏳ 頂層僅 port 宣告，尚無實作（見檔案本體）
- **Description:** 凸包演算法硬體實作，用於計算幾何問題
- **Key Features:** 凸包計算、座標處理、硬體加速

### 2024 Projects

#### Bicubic Interpolation (`bicubic/`)
- **Module:** `Bicubic.v`
- **Description:** 實作雙三次插值演算法，用於影像放大與品質提升
- **Key Features:** 固定點運算、記憶體管理、流水線設計

#### HMC (`HMC/icc2024cb/`)
- **Module:** `HMC.sv`
- **Description:** 硬體加速器設計，包含處理單元陣列(PE Array)
- **Key Features:** 雙時鐘域設計、SRAM/ROM 記憶體介面

### 2021 Projects

#### Geofence (`geofence/`)
- **Module:** `geofence.v`
- **RTL 狀態：** ⏳ 頂層僅 port 宣告，尚無實作
- **Description:** 地理圍欄演算法硬體實作，用於位置判斷
- **Key Features:** 座標計算、區域判斷、硬體加速

### 2020 Projects

#### String Matching Engine (`String_matching/`)
- **Module:** `SME.sv`
- **Description:** 高效能字串匹配引擎硬體實作
- **Key Features:** 並行比較邏輯、狀態機設計

#### SCE (`SCE/`)
- **Module:** `SCE.v`
- **Description:** 信號處理器設計，支援 DFT 與 PrimeTime 分析
- **Key Features:** 信號處理、記憶體管理、DFT 測試

### 2019 Projects

#### GPS Data Compression (`GPSDC/`)
- **Module:** `GPSDC.v`
- **RTL 狀態：** ⏳ 頂層僅 port 宣告，尚無實作（`SIM`／`SYN` 腳本仍存在）
- **Description:** GPS 數據壓縮硬體實作
- **Key Features:** 數據壓縮、GPS 座標處理

#### Image Convolutional (`Image_convolutional/`)
- **Module:** `CONV.sv`
- **Description:** 影像卷積神經網路硬體加速器，支援多層卷積運算
- **Key Features:** 
  - 3x3 卷積核心運算
  - Max Pooling 硬體實作
  - ReLU 激活函數
  - 多層資料流控制
  - DFT 測試支援

#### IoT Data Filter (`IOTDF/`)
- **Module:** `IOTDF.v`
- **Description:** 物聯網數據過濾器，支援多種統計運算
- **Key Features:**
  - 最大值/最小值/平均值計算
  - 峰值檢測
  - 數據提取與排除功能
  - PrimeTime 時序分析

### 2018 Projects

#### Huffman Encoder (`huffman/`)
- **Module:** `huffman.v`
- **Description:** 霍夫曼編碼器硬體實作，用於數據壓縮
- **Key Features:** 動態編碼表生成、位元流輸出

#### LCD Controller (`LCD_CTRL/`)
- **Module:** `LCD_CTRL.sv`
- **Description:** LCD 控制器設計，用於顯示控制
- **Key Features:** 顯示控制、時序管理、介面設計

#### RF 定位 — RSSI（`RF/`，模組 `RFILE`）
- **Module:** `RFILE.v`
- **Description:** 三錨點座標與 RSSI 推算目標位置（Wi‑Fi／定位類題型）；**非**一般意義之 Register File
- **Key Features:** RSSI 路徑、距離／加權運算、線性方程組求解、輸出目標座標 `(xt, yt)`

#### TPA (`TPA/`)
- **Module:** TPA Signal Processor
- **Description:** 信號處理加速器設計，支援 DFT 與 PrimeTime 分析
- **Key Features:** 信號處理、DFT 測試、時序分析

## 🔧 Usage

### 專案結構

每個專案目錄包含：
- **RTL/**: RTL 原始碼檔案
- **SIM/**: 模擬測試平台與腳本
- **SYN/**: 合成腳本、時序約束與報告
- **DFT/**: DFT/ATPG 腳本（可選）
- **prime_time/**: PrimeTime 靜態時序分析腳本（可選）
- **work/**: 建置輸出與日誌檔案
- **Makefile**: 自動化建置腳本

### Makefile 使用說明

本專案使用 Makefile 自動化整個 IC 設計流程，從 RTL 模擬到合成、ATPG 與靜態時序分析。

#### 前置準備

**重要：使用 Makefile 前，請先完成以下步驟：**

1. **創建 work 資料夾**
   ```bash
   mkdir work
   ```

2. **將 Makefile 複製到 work 資料夾**
   ```bash
   cp Makefile work/
   ```

3. **進入 work 資料夾**
   ```bash
   cd work
   ```

4. **執行 make start 建立專案結構**
   ```bash
   make start
   ```

> **注意**：Makefile 必須放在 `work/` 資料夾內才能正常運作，因為 Makefile 中的路徑設定是相對於 work 資料夾的。

#### 基本指令

```bash
# 查看所有可用指令
make help

# 建立專案目錄結構（首次使用時）
make start

# RTL 模擬
make sim_rtl

# Gate-level 模擬（需先執行合成）
make sim_gate

# 執行合成
make syn

# 執行 TetraMAX ATPG
make tetra_max

# 執行 PrimeTime 靜態時序分析
make prime_time

# 清理暫存檔案
make clean          # 清理所有暫存檔案
make clean_sim      # 清理 SIM 目錄
make clean_syn      # 清理 SYN 目錄
make clean_atpg     # 清理 DFT 目錄
make clean_pt       # 清理 PrimeTime 目錄
make clean_work     # 清理 work 目錄
```

#### 環境變數設定

Makefile 支援以下環境變數來自訂執行參數：

**1. 選擇模擬器 (`SIM`)**
```bash
# 使用 xrun (預設)
make sim_rtl SIM=xrun

# 使用 ncverilog
make sim_rtl SIM=ncverilog

# 使用 VCS
make sim_rtl SIM=vcs
```

**2. 指定測試模式 (`PATTERN`)**
```bash
# 使用預設模式 (tb1)
make sim_rtl

# 指定特定測試模式
make sim_rtl PATTERN=tb2
make sim_rtl PATTERN=P1
```

**3. 組合使用**
```bash
# 使用 VCS 執行特定測試模式的 RTL 模擬
make sim_rtl SIM=vcs PATTERN=tb2

# 使用 xrun 執行 Gate-level 模擬
make sim_gate SIM=xrun PATTERN=tb1
```

#### 完整工作流程範例

```bash
# 1. 進入專案目錄
cd 2024/bicubic

# 2. 創建 work 資料夾（如果尚未存在）
mkdir -p work

# 3. 將 Makefile 複製到 work 資料夾
cp ../../Makefile work/

# 4. 進入 work 資料夾
cd work

# 5. 建立專案結構（首次使用）
make start

# 3. 執行 RTL 模擬驗證功能
make sim_rtl SIM=xrun PATTERN=tb1

# 4. 執行合成產生網表
make syn

# 5. 執行 Gate-level 模擬驗證時序
make sim_gate SIM=xrun PATTERN=tb1

# 6. 執行 PrimeTime 靜態時序分析
make prime_time

# 7. 執行 TetraMAX ATPG（如需要）
make tetra_max

# 8. 清理暫存檔案
make clean
```

#### 自訂路徑變數

如需修改預設路徑，可在 Makefile 中設定或透過環境變數覆蓋：

```bash
# 自訂 RTL 目錄路徑
make sim_rtl RTL_DIR=../custom_rtl

# 自訂合成腳本路徑
make syn SYN_TCL=../SYN/custom_syn.tcl
```

#### 注意事項

1. **首次使用**：建議先執行 `make start` 建立完整的目錄結構
2. **模擬器選擇**：確保系統已安裝並設定好對應的 EDA 工具（xrun/ncverilog/VCS）
3. **合成前置**：執行 Gate-level 模擬前需先完成合成 (`make syn`)
4. **日誌檔案**：所有執行日誌會自動儲存在 `work/` 目錄下
5. **清理檔案**：定期執行 `make clean` 可釋放磁碟空間

### 傳統手動執行方式

若不使用 Makefile，也可手動執行：

**RTL 模擬：**
```bash
cd <year>/<project>/SIM
xrun -sv +access+r +notimingcheck testfixture.v ../RTL/module.sv
```

**合成：**
```bash
cd <year>/<project>/SYN
dc_shell -f DC_syn.tcl
```

## 📚 References

- [教育部 IC 設計競賽官方網站](https://www.iccontest2026.com/)
- TSMC Standard Cell Library Documentation
- Synopsys Design Compiler User Guide

## 📄 License

This repository is for educational and contest purposes only.

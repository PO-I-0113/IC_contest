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

## 📊 Solution Summary

> **Note:** Detailed architecture diagrams and synthesis reports can be found in each year's sub-directory.

| Year | Problem Name | Module Name | Category | Description |
| :--- | :--- | :--- | :--- | :--- |
| **2024** | Bicubic Interpolation | `Bicubic` | Image Processing | 雙三次插值影像處理硬體實作 |
| **2024** | HMC | `HMC` | Signal Processing | 硬體加速器設計 |
| **2020** | String Matching Engine | `SME` | String Processing | 字串匹配引擎硬體實作 |
| **2020** | SCE | `SCE` | Signal Processing | 信號處理器設計 |
| **2019** | Image Convolutional | `CONV` | Image Processing | 影像卷積神經網路硬體加速器 |
| **2019** | IoT Data Filter | `IOTDF` | Data Processing | 物聯網數據過濾器 |
| **2018** | Huffman Encoder | `huffman` | Data Compression | 霍夫曼編碼器硬體實作 |
| **2018** | Register File | `RFILE` | Memory Design | 暫存器檔案設計 |

## 📂 Directory Structure

```text
.
├── 2024/
│   ├── bicubic/              # Bicubic Interpolation
│   │   ├── RTL/              # RTL source files
│   │   ├── SIM/              # Simulation testbenches
│   │   ├── SYN/              # Synthesis scripts and reports
│   │   ├── DFT/              # DFT/ATPG scripts (optional)
│   │   ├── prime_time/       # PrimeTime scripts (optional)
│   │   ├── work/             # Build outputs and logs
│   │   └── Makefile          # Build automation script
│   └── HMC/                  # HMC Accelerator
│       └── icc2024cb/
│           ├── RTL/          # RTL source files
│           ├── SIM/          # Simulation testbenches
│           ├── SYN/          # Synthesis scripts and reports
│           ├── DFT/          # DFT/ATPG scripts (optional)
│           ├── prime_time/   # PrimeTime scripts (optional)
│           ├── work/         # Build outputs and logs
│           └── Makefile      # Build automation script
├── 2020/
│   ├── String_matching/      # String Matching Engine (SME)
│   │   ├── RTL/              # RTL source files
│   │   ├── SIM/              # Simulation testbenches
│   │   ├── SYN/              # Synthesis scripts and reports
│   │   └── Makefile          # Build automation script
│   └── SCE/                  # SCE Processor
│       └── icc2020cb/
│           ├── RTL/          # RTL source files
│           ├── SIM/          # Simulation testbenches
│           ├── SYN/          # Synthesis scripts and reports
│           └── Makefile      # Build automation script
├── 2019/
│   ├── Image_convolutional/   # Image Convolutional Neural Network
│   │   ├── RTL/              # RTL source files (CONV.sv)
│   │   ├── SIM/              # Simulation testbenches
│   │   ├── SYN/              # Synthesis scripts and reports
│   │   └── Makefile          # Build automation script
│   └── IOTDF/                # IoT Data Filter
│       ├── RTL/              # RTL source files (IOTDF.v)
│       ├── SIM/              # Simulation testbenches
│       ├── SYN/              # Synthesis scripts and reports
│       └── Makefile          # Build automation script
├── 2018/
│   ├── hufffman/             # Huffman Encoder
│   │   └── B_ICC2018_priliminary_grad_cell_based/
│   │       ├── RTL/          # RTL source files
│   │       ├── SIM/          # Simulation testbenches
│   │       ├── SYN/          # Synthesis scripts and reports
│   │       └── Makefile      # Build automation script
│   └── RF/                   # Register File
│       └── B_ICC2018_grad_cell-based/
│           ├── RTL/          # RTL source files (RFILE.v)
│           ├── SIM/          # Simulation testbenches
│           ├── SYN/          # Synthesis scripts and reports
│           └── Makefile      # Build automation script
├── Makefile                  # Root Makefile template
└── README.md
```

## 📝 Project Details

### 2024 Projects

#### Bicubic Interpolation (`bicubic/`)
- **Module:** `Bicubic.v`
- **Description:** 實作雙三次插值演算法，用於影像放大與品質提升
- **Key Features:** 固定點運算、記憶體管理、流水線設計

#### HMC (`HMC/icc2024cb/`)
- **Module:** `HMC.sv`
- **Description:** 硬體加速器設計，包含處理單元陣列(PE Array)
- **Key Features:** 雙時鐘域設計、SRAM/ROM 記憶體介面

### 2020 Projects

#### String Matching Engine (`String_matching/`)
- **Module:** `SME.sv`
- **Description:** 高效能字串匹配引擎硬體實作
- **Key Features:** 並行比較邏輯、狀態機設計

#### SCE (`SCE/icc2020cb/`)
- **Module:** `SCE.v`
- **Description:** 信號處理器設計
- **Key Features:** 閾值處理、記憶體管理

### 2019 Projects

#### Image Convolutional (`Image_convolutional/`)
- **Module:** `CONV.sv`
- **Description:** 影像卷積神經網路硬體加速器，支援多層卷積運算
- **Key Features:** 
  - 3x3 卷積核心運算
  - Max Pooling 硬體實作
  - ReLU 激活函數
  - 多層資料流控制

#### IoT Data Filter (`IOTDF/`)
- **Module:** `IOTDF.v`
- **Description:** 物聯網數據過濾器，支援多種統計運算
- **Key Features:**
  - 最大值/最小值/平均值計算
  - 峰值檢測
  - 數據提取與排除功能

### 2018 Projects

#### Huffman Encoder (`hufffman/`)
- **Module:** `huffman.v`
- **Description:** 霍夫曼編碼器硬體實作，用於數據壓縮
- **Key Features:** 動態編碼表生成、位元流輸出

#### Register File (`RF/`)
- **Module:** `RFILE.v`
- **Description:** 高效能暫存器檔案設計
- **Key Features:** 流水線設計、多端口讀寫

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
cd 2024/bicubic/work

# 2. 建立專案結構（首次使用）
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
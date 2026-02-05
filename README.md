# 🏆 Digital IC Design Contest Archive

![Status](https://img.shields.io/badge/Status-Maintained-success)
![Language](https://img.shields.io/badge/Language-Verilog%20%2F%20SystemVerilog-blue)
![Tools](https://img.shields.io/badge/Tools-Design%20Compiler%20%7C%20VCS%20%7C%20Verdi-orange)

## 📖 Overview

This repository documents my solutions for the **National Undergraduate/Graduate IC Design Contest (教育部 IC 設計競賽)**. It serves as a comprehensive record of my training in digital circuit design, RTL coding, and hardware optimization strategies.

Each project involves translating algorithmic specifications into synthesizable Verilog HDL, verifying functionality against testbenches, and optimizing for **Power, Performance, and Area (PPA)**.

## 🛠️ Tech Stack & Environment

* **RTL Design:** Verilog / SystemVerilog
* **Verification:** Cadence ncverilog / Synopsys VCS
* **Synthesis:** Synopsys Design Compiler (DC)
* **Process Technology:** TSMC .18um / 90nm (Based on contest specs)

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
│   │   └── SYN/              # Synthesis scripts and reports
│   └── HMC/                  # HMC Accelerator
│       └── icc2024cb/
│           ├── RTL/          # RTL source files
│           ├── SIM/          # Simulation testbenches
│           └── SYN/          # Synthesis scripts and reports
├── 2020/
│   ├── String_matching/      # String Matching Engine (SME)
│   │   ├── RTL/              # RTL source files
│   │   ├── SIM/              # Simulation testbenches
│   │   └── SYN/              # Synthesis scripts and reports
│   └── SCE/                  # SCE Processor
│       └── icc2020cb/
│           ├── RTL/          # RTL source files
│           ├── SIM/          # Simulation testbenches
│           └── SYN/          # Synthesis scripts and reports
├── 2019/
│   ├── Image_convolutional/   # Image Convolutional Neural Network
│   │   ├── RTL/              # RTL source files (CONV.sv)
│   │   ├── SIM/              # Simulation testbenches
│   │   └── SYN/              # Synthesis scripts and reports
│   └── IOTDF/                # IoT Data Filter
│       ├── RTL/              # RTL source files (IOTDF.v)
│       ├── SIM/              # Simulation testbenches
│       └── SYN/              # Synthesis scripts and reports
├── 2018/
│   ├── hufffman/             # Huffman Encoder
│   │   └── B_ICC2018_priliminary_grad_cell_based/
│   │       ├── RTL/          # RTL source files
│   │       ├── SIM/          # Simulation testbenches
│   │       └── SYN/          # Synthesis scripts and reports
│   └── RF/                   # Register File
│       └── B_ICC2018_grad_cell-based/
│           ├── RTL/          # RTL source files (RFILE.v)
│           ├── SIM/          # Simulation testbenches
│           └── SYN/          # Synthesis scripts and reports
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

Each project directory contains:
- **RTL/**: RTL source code files
- **SIM/**: Simulation testbenches and scripts
- **SYN/**: Synthesis scripts, constraints, and reports

To run simulation:
```bash
cd <year>/<project>/SIM
# Follow project-specific instructions
```

To run synthesis:
```bash
cd <year>/<project>/SYN
# Run Design Compiler with provided scripts
```

## 📚 References

- [教育部 IC 設計競賽官方網站](https://www.iccontest.org.tw/)
- TSMC Standard Cell Library Documentation
- Synopsys Design Compiler User Guide

## 📄 License

This repository is for educational and contest purposes only.
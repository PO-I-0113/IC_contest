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

## 📊 Solution Summary (PPA Highlights)

> **Note:** Detailed architecture diagrams and synthesis reports can be found in each year's sub-directory.

| Year | Problem Name | Category | Area (Gate Count) | Cycle Time | Key Optimization Strategy |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **2023** | Laser Engine | Image Processing | 5,420 | 10.0 ns | Shared Arithmetic Unit (AU) to reduce area |
| **2022** | JAM | Search Algorithm | 3,850 | 8.5 ns | Optimized FSM state transitions |
| **2021** | Geofence | Computational Geometry | 7,100 | 12.0 ns | Pipelined Datapath for high throughput |
| **2020** | SME | String Matching | 12,500 | 9.8 ns | Parallel comparison logic |

*(👆 以上表格內容為範例，請替換成你實際做出來的數據，這張表是面試官最愛看的！)*

## 📂 Directory Structure

```text
.
├── 2023_Laser_Engine/   # Distance calculation and sorting hardware
├── 2022_JAM/            # Job Assignment Machine (Graph theory)
├── 2021_Geofence/       # Point inclusion detection
├── common/              # Shared headers and script templates
└── README.md

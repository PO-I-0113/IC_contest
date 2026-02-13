.PHONY: sim sim_rtl sim_gate syn tetra_max prime_time clean clean_sim clean_syn clean_work clean_atpg clean_pt clean_dft

# 環境變數設定 - 資料夾路徑
RTL_DIR ?= ../RTL
SIM_DIR ?= ../SIM
SYN_DIR ?= ../SYN
DFT_DIR ?= ../DFT
PT_DIR ?= ../prime_time

# 環境變數設定 - 模擬器選擇 (xrun, ncverilog, vcs)
SIM ?= xrun
PATTERN ?= tb1
# 環境變數設定 - 檔案路徑
TECH_VERILOG ?= /mnt2/CBDK_TSMC_130nm_Arm_v2.5/Verilog/tsmc13_neg.v
TESTBENCH ?= $(SIM_DIR)/testfixture.v
RTL ?= $(RTL_DIR)/LCD_CTRL.sv
NETLIST ?= $(SYN_DIR)/netlist/LCD_CTRL_syn.v
SYN_TCL ?= $(SYN_DIR)/DC_syn.tcl
SDF_FILE ?= $(SYN_DIR)/netlist/LCD_CTRL_syn.sdf


# TetraMAX (ATPG) 相關設定
ATPG_TCL ?= $(DFT_DIR)/tetramax.tcl
ATPG_NETLIST ?= $(NETLIST)
ATPG_SDC ?= $(SYN_DIR)/LCD_CTRL.sdc

# PrimeTime 相關設定
PT_TCL ?= $(PT_DIR)/pt.tcl
PT_NETLIST ?= $(NETLIST)
PT_SDC ?= $(SYN_DIR)/CONV.sdc

# 條件式 define：如果 PATTERN 有值就加上 +define+$(PATTERN)
ifneq ($(PATTERN),)
  DEFINE_FLAG = +define+$(PATTERN)
  DEFINE_FLAG_GATE = +define+$(PATTERN)+SDF
else
  DEFINE_FLAG =
  DEFINE_FLAG_GATE = +define+SDF
endif

# 根據模擬器設定完整的命令結構
ifeq ($(SIM),xrun)
  # xrun 命令結構
  SIM_RTL_CMD = xrun -sv +access+r +notimingcheck $(TESTBENCH) $(RTL) $(DEFINE_FLAG)
  SIM_GATE_CMD = xrun  +access+r $(TESTBENCH) $(NETLIST) $(DEFINE_FLAG_GATE) $(TECH_VERILOG)
else ifeq ($(SIM),ncverilog)
  # ncverilog 命令結構
  SIM_RTL_CMD = ncverilog -sv +access+r +notimingcheck $(TESTBENCH) $(RTL) $(DEFINE_FLAG)
  SIM_GATE_CMD = ncverilog -sv +access+r $(TESTBENCH) $(NETLIST) $(DEFINE_FLAG_GATE) $(TECH_VERILOG)
else ifeq ($(SIM),vcs)
  # VCS 命令結構（兩階段：編譯 + 執行）
  SIM_RTL_CMD = vcs -sverilog +access+r +notimingcheck $(DEFINE_FLAG) $(TESTBENCH) $(RTL) -o simv_rtl && ./simv_rtl
  SIM_GATE_CMD = vcs -sverilog +access+r +neg_tchk +reconfig $(DEFINE_FLAG_GATE) $(TESTBENCH) $(NETLIST) $(TECH_VERILOG) -o simv_gate && ./simv_gate
else
  $(error 不支援的模擬器: $(SIM). 請選擇 xrun, ncverilog 或 vcs)
endif

help:
	@echo "Usage: make [target] [SIM=simulator] [PATTERN=pattern]"
	@echo "Create project directory structure and run simulation"
	@echo "  make start"
	@echo ""
	@echo "Targets:"
	@echo "  sim_rtl: Run RTL simulation"
	@echo "  sim_gate: Run gate-level simulation"
	@echo "  syn: Run synthesis"
	@echo "  tetra_max: Run TetraMAX ATPG"
	@echo "  prime_time: Run PrimeTime static timing analysis"
	@echo "  start: Create project directory structure"
	@echo "  clean_sim: Clean SIM directory"
	@echo "  clean_syn: Clean SYN directory"
	@echo "  clean_atpg: Clean DFT directory"
	@echo "  clean_pt: Clean PT directory"
	@echo "  clean_work: Clean work directory"
	@echo "  clean: Clean all temporary files"
	@echo ""
	@echo "Options:"
	@echo "  SIM=simulator: Choose simulator (xrun, ncverilog, vcs). Default: xrun"
	@echo "    Example: make sim_rtl SIM=vcs"
	@echo "  PATTERN=pattern: Set define pattern (e.g., P1, P2, P3). Default: P3"
	@echo "    Example: make sim_rtl PATTERN=P1"
	@echo "    Example: make sim_rtl SIM=xrun PATTERN=P2"

sim_rtl:
	@echo "執行 RTL 模擬 (模擬器: $(SIM), Pattern: $(PATTERN))..."
	@cd $(SIM_DIR) && $(SIM_RTL_CMD) | tee ../work/sim_rtl.log

sim_gate:
	@echo "執行 Gate-level 模擬 (模擬器: $(SIM), Pattern: $(PATTERN))..."
	@cd $(SIM_DIR) && $(SIM_GATE_CMD) | tee ../work/sim_gate.log

syn:
	@echo "執行合成 (Synthesis)..."
	@cd $(SYN_DIR) && dc_shell -f $(SYN_TCL) | tee ../work/dc.log

tetra_max:
	@echo "執行 TetraMAX ATPG ..."
	@cd $(DFT_DIR) && tetramax -shell -f $(ATPG_TCL) | tee ../work/tetramax.log

prime_time:
	@echo "執行 PrimeTime 靜態時序分析..."
	@cd $(PT_DIR) && pt_shell -f $(PT_TCL) | tee ../work/pt.log

# 開始專案建立
start:
	@echo "創立資料夾結構"
	@mkdir -p $(SIM_DIR)
	@mkdir -p $(SYN_DIR)/report/
	@mkdir -p $(SYN_DIR)/netlist/
	@mkdir -p $(DFT_DIR)
	@mkdir -p $(PT_DIR)
	@mkdir -p $(RTL_DIR)
	@mv ../*.v $(RTL_DIR) 2>/dev/null || true
	@mv ../*.dat $(SIM_DIR) 2>/dev/null || true
	@mv ../*.tcl $(SYN_DIR) 2>/dev/null || true
	@mv ../*.sdc $(SYN_DIR) 2>/dev/null || true
	@mv ../*.synopsys_dc.setup $(SYN_DIR) 2>/dev/null || true
	
# 清除暫存檔案
clean_sim:
	@echo "清除 SIM 資料夾暫存檔案..."
	@cd $(SIM_DIR) && rm -rf *.log *.fsdb *.vcd *.history xcelium.d nWaveLog novas_dump.log ida_diagnostics.log command.log filenames.log *.cmd xrun.history xmverilog.history *.key *nova* csrc simv.daidir simv ucli.key vc_hdrs.h .vcs* DVEfiles *.sdf.X

clean_syn:
	@echo "清除 SYN 資料夾暫存檔案..."
	@cd $(SYN_DIR) && rm -rf alib-* dc.log command.log filenames*.log

clean_atpg: clean_dft

clean_dft:
	@echo "清除 DFT 資料夾暫存檔案..."
	@if [ -d "$(DFT_DIR)" ]; then \
		cd $(DFT_DIR) && rm -rf *.log *.rpt *.stil *.v *.spf *.spf.gz *.vcd *.fsdb command.log filenames*.log tetramax.log; \
	fi

clean_pt:
	@echo "清除 PT 資料夾暫存檔案..."
	@if [ -d "$(PT_DIR)" ]; then \
		cd $(PT_DIR) && rm -rf *.log *.spef command.log filenames*.log pt.log; \
	fi

clean_work:
	@echo "清除 work 資料夾暫存檔案..."
	@rm -f *.log

clean: clean_sim clean_syn clean_atpg clean_pt clean_work
	@echo "所有暫存檔案已清除完成！"

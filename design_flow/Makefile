# ============================================================
# IC Design Flow Makefile (方案 A)
# 製程: TECH=U18|TSMC13|ADFP|TN16|TN7
# Clock 分層: CLK=10 → syn/netlist|report|dft_report/clk_10/
# ============================================================

TOP      ?= DESIGN_TOP
TECH     ?= U18
CLK      ?= 10           # → clk_$(CLK) 子目錄
RTL_FILE ?= rtl/src/$(TOP).v
TB_FILE  ?= sim/tb/tb_$(TOP).sv
FILELIST ?= rtl/filelist.f

SIM      ?= vcs
WORK     ?= work
GATE_NET ?= auto         # auto | syn | dft（sim_gate 用）
TIMING   ?= 1            # 1=timing check；0=+notimingcheck
# 製程 cell verilog（相對路徑；可覆寫）
TECH_VERILOG ?= lib/$(TECH)/stdcell/typical.v

TCL_SET  = set TOP $(TOP); set TECH $(TECH); set CLK $(CLK)

GREEN := \033[0;32m
RED   := \033[0;31m
NC    := \033[0m

.PHONY: help start check_tech sim sim_gate cov spyglass syn syn_dft lec tmax pt apr clean clean_all

help:
	@echo ""
	@echo "IC Design Flow (cwd = design_flow/)"
	@echo "  make syn          - 合成（無 scan）"
	@echo "  make syn_dft      - 合成 + scan chain（DFT）"
	@echo "  make sim          - RTL 模擬"
	@echo "  make sim_gate     - Gate-level 模擬（netlist + SDF + tech verilog）"
	@echo "  make lec / pt / tmax / apr / spyglass / cov"
	@echo ""
	@echo "製程 TECH: U18 | TSMC13 | ADFP | TN16 | TN7"
	@echo "  make syn TECH=U18"
	@echo ""
	@echo "Clock 分層 CLK → syn/{netlist,report,dft_report}/clk_<CLK>/"
	@echo "  make syn      CLK=10"
	@echo "  make syn_dft  CLK=10 TECH=U18"
	@echo "  make sim_gate CLK=10 TECH=U18"
	@echo "  make sim_gate CLK=10 GATE_NET=dft"
	@echo "  make sim_gate CLK=10 GATE_NET=syn TIMING=0"
	@echo "  make pt       CLK=10 TECH=U18"
	@echo ""
	@echo "SDC 優先: syn/constraint/\$$(TOP)_clk\$$(CLK).sdc"
	@echo "         否則 syn/constraint/\$$(TOP).sdc"
	@echo ""
	@echo "預設: TOP=$(TOP)  TECH=$(TECH)  CLK=$(CLK)  GATE_NET=$(GATE_NET)"
	@echo ""

start:
	@mkdir -p $(WORK)/sim $(WORK)/sim_gate/clk_$(CLK)
	@mkdir -p syn/netlist/clk_$(CLK) syn/report/clk_$(CLK) syn/dft_report/clk_$(CLK)
	@mkdir -p sim/report/clk_$(CLK)
	@mkdir -p lec/report/clk_$(CLK) lec/session/clk_$(CLK)
	@mkdir -p tmax/report/clk_$(CLK) tmax/pattern/clk_$(CLK)
	@mkdir -p primetime/report/clk_$(CLK) apr/report/clk_$(CLK)
	@echo "$(GREEN)[INFO]$(NC) dirs ready for clk_$(CLK)"

check_tech:
	@if [ ! -d "lib/$(TECH)" ]; then \
		echo "$(RED)[ERROR]$(NC) 找不到製程目錄: lib/$(TECH)"; \
		echo "        可用: U18 TSMC13 ADFP TN16 TN7"; \
		exit 1; \
	fi
	@echo "$(GREEN)[INFO]$(NC) TECH=$(TECH)  CLK=$(CLK)  tag=clk_$(CLK)"

sim: start
ifeq ($(SIM),vcs)
	vcs -full64 -sverilog -debug_access+all \
		-f $(FILELIST) $(TB_FILE) \
		-o $(WORK)/sim/simv
	./$(WORK)/sim/simv | tee $(WORK)/sim/sim.log
else
	xrun -sv -f $(FILELIST) $(TB_FILE) | tee $(WORK)/sim/sim.log
endif

# ---------- Gate-level 模擬 ----------
sim_gate: start check_tech
	@chmod +x sim/script/run_sim_gate.sh
	TOP=$(TOP) TECH=$(TECH) CLK=$(CLK) SIM=$(SIM) \
	GATE_NET=$(GATE_NET) TIMING=$(TIMING) \
	TECH_VERILOG=$(TECH_VERILOG) TB_FILE=$(TB_FILE) \
	bash sim/script/run_sim_gate.sh

cov: start
	cd cov/script && bash run_cov.sh $(TOP) $(SIM)

spyglass: start
	cd spyglass/script && sg_shell -x '$(TCL_SET)' -tcl run_spyglass.tcl

# ---------- 一般合成 ----------
syn: start check_tech
	@if [ ! -f "lib/$(TECH)/setup_dc.tcl" ]; then \
		echo "$(RED)[ERROR]$(NC) 缺少 lib/$(TECH)/setup_dc.tcl"; exit 1; \
	fi
	cd syn/script && dc_shell -x '$(TCL_SET)' -f run_syn.tcl \
		| tee ../report/clk_$(CLK)/syn.log

# ---------- 合成 + Scan Chain ----------
syn_dft: start check_tech
	@if [ ! -f "lib/$(TECH)/setup_dc.tcl" ]; then \
		echo "$(RED)[ERROR]$(NC) 缺少 lib/$(TECH)/setup_dc.tcl"; exit 1; \
	fi
	cd syn/script && dc_shell -x '$(TCL_SET)' -f run_syn_dft.tcl \
		| tee ../dft_report/clk_$(CLK)/syn_dft.log

lec: start check_tech
	cd lec/script && fm_shell -x '$(TCL_SET)' -f run_lec.tcl \
		| tee ../report/clk_$(CLK)/lec.log

tmax: start
	cd tmax/script && TOP=$(TOP) TECH=$(TECH) CLK=$(CLK) tmax -shell run_tmax.tcl \
		| tee ../report/clk_$(CLK)/tmax.log

pt: start check_tech
	@if [ ! -f "lib/$(TECH)/setup_pt.tcl" ]; then \
		echo "$(RED)[ERROR]$(NC) 缺少 lib/$(TECH)/setup_pt.tcl"; exit 1; \
	fi
	cd primetime/script && pt_shell -x '$(TCL_SET)' -f run_pt.tcl \
		| tee ../report/clk_$(CLK)/pt.log

apr: start
	cd apr/script && TOP=$(TOP) CLK=$(CLK) bash run_apr.sh

clean:
	rm -rf $(WORK)

clean_all: clean
	@find syn/netlist syn/report syn/dft_report \
	      sim/report \
	      lec/report lec/session \
	      tmax/report tmax/pattern primetime/report primetime/spef \
	      apr/def apr/gds apr/report cov/report spyglass/report \
	      -type f ! -name '.gitkeep' -delete 2>/dev/null || true
	@echo "$(GREEN)[INFO]$(NC) cleaned generated outputs"

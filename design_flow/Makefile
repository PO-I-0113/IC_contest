# ============================================================
# IC Design Flow Makefile
# TECH : U18|TSMC13|ADFP|TN16|TN7
# CLK  : → clk_<CLK>/
# SCAN : 0=一般 syn netlist；1=DFT/scan netlist（後段統一）
# ============================================================

TOP      ?= DESIGN_TOP
TECH     ?= U18
CLK      ?= 10
SCAN     ?= 0            # 預設 0=不用 scan；1=DFT netlist
RTL_FILE ?= rtl/src/$(TOP).v
TB_FILE  ?= sim/tb/tb_$(TOP).sv
FILELIST ?= rtl/filelist.f

SIM      ?= vcs
WORK     ?= work
# GATE_NET 可覆寫 sim_gate；空字串則跟 SCAN（預設 syn）
GATE_NET ?=
TIMING   ?= 1
TECH_VERILOG ?= lib/$(TECH)/stdcell/typical.v

TCL_SET  = set TOP $(TOP); set TECH $(TECH); set CLK $(CLK); set SCAN $(SCAN)

GREEN := \033[0;32m
RED   := \033[0;31m
NC    := \033[0m

ifeq ($(SCAN),1)
  NET_TAG := dft
else
  NET_TAG := syn
endif

.PHONY: help start check_tech sim sim_gate cov spyglass syn syn_dft lec tmax pt apr clean clean_all

help:
	@echo ""
	@echo "IC Design Flow (cwd = design_flow/)"
	@echo "  make syn / syn_dft / sim / sim_gate / lec / pt / tmax / apr"
	@echo ""
	@echo "預設不用 scan（SCAN=0 → *_syn.v），一般可省略 SCAN："
	@echo "  make syn CLK=10"
	@echo "  make lec CLK=10"
	@echo "  make pt  CLK=10"
	@echo "  make sim_gate CLK=10"
	@echo ""
	@echo "需要 DFT/scan 時再顯式打開："
	@echo "  make syn_dft CLK=10"
	@echo "  make lec / pt / sim_gate / tmax / apr  SCAN=1 CLK=10"
	@echo ""
	@echo "變數: TECH=$(TECH)  CLK=$(CLK)  SCAN=$(SCAN)（0=syn, 1=dft）"
	@echo ""

start:
	@mkdir -p $(WORK)/sim $(WORK)/sim_gate/clk_$(CLK)/$(NET_TAG)
	@mkdir -p syn/netlist/clk_$(CLK) syn/report/clk_$(CLK) syn/dft_report/clk_$(CLK)
	@mkdir -p sim/report/clk_$(CLK)/$(NET_TAG)
	@mkdir -p lec/report/clk_$(CLK)/$(NET_TAG) lec/session/clk_$(CLK)/$(NET_TAG)
	@mkdir -p tmax/report/clk_$(CLK)/$(NET_TAG) tmax/pattern/clk_$(CLK)/$(NET_TAG)
	@mkdir -p primetime/report/clk_$(CLK)/$(NET_TAG) apr/report/clk_$(CLK)/$(NET_TAG)
	@echo "$(GREEN)[INFO]$(NC) dirs ready  clk_$(CLK)/$(NET_TAG)  SCAN=$(SCAN)"

check_tech:
	@if [ ! -d "lib/$(TECH)" ]; then \
		echo "$(RED)[ERROR]$(NC) 找不到製程目錄: lib/$(TECH)"; exit 1; \
	fi
	@echo "$(GREEN)[INFO]$(NC) TECH=$(TECH) CLK=$(CLK) SCAN=$(SCAN) NET_TAG=$(NET_TAG)"

sim: start
ifeq ($(SIM),vcs)
	vcs -full64 -sverilog -debug_access+all \
		-f $(FILELIST) $(TB_FILE) \
		-o $(WORK)/sim/simv
	./$(WORK)/sim/simv | tee $(WORK)/sim/sim.log
else
	xrun -sv -f $(FILELIST) $(TB_FILE) | tee $(WORK)/sim/sim.log
endif

sim_gate: start check_tech
	@chmod +x sim/script/run_sim_gate.sh
	TOP=$(TOP) TECH=$(TECH) CLK=$(CLK) SCAN=$(SCAN) SIM=$(SIM) \
	GATE_NET="$(GATE_NET)" TIMING=$(TIMING) \
	TECH_VERILOG=$(TECH_VERILOG) TB_FILE=$(TB_FILE) \
	bash sim/script/run_sim_gate.sh

cov: start
	cd cov/script && bash run_cov.sh $(TOP) $(SIM)

spyglass: start
	cd spyglass/script && sg_shell -x '$(TCL_SET)' -tcl run_spyglass.tcl

syn: start check_tech
	@if [ ! -f "lib/$(TECH)/setup_dc.tcl" ]; then \
		echo "$(RED)[ERROR]$(NC) 缺少 lib/$(TECH)/setup_dc.tcl"; exit 1; \
	fi
	cd syn/script && dc_shell -x '$(TCL_SET)' -f run_syn.tcl \
		| tee ../report/clk_$(CLK)/syn.log

syn_dft: start check_tech
	@if [ ! -f "lib/$(TECH)/setup_dc.tcl" ]; then \
		echo "$(RED)[ERROR]$(NC) 缺少 lib/$(TECH)/setup_dc.tcl"; exit 1; \
	fi
	cd syn/script && dc_shell -x '$(TCL_SET)' -f run_syn_dft.tcl \
		| tee ../dft_report/clk_$(CLK)/syn_dft.log

lec: start check_tech
	cd lec/script && fm_shell -x '$(TCL_SET)' -f run_lec.tcl \
		| tee ../report/clk_$(CLK)/$(NET_TAG)/lec.log

tmax: start
	cd tmax/script && TOP=$(TOP) TECH=$(TECH) CLK=$(CLK) SCAN=$(SCAN) tmax -shell run_tmax.tcl \
		| tee ../report/clk_$(CLK)/$(NET_TAG)/tmax.log

pt: start check_tech
	@if [ ! -f "lib/$(TECH)/setup_pt.tcl" ]; then \
		echo "$(RED)[ERROR]$(NC) 缺少 lib/$(TECH)/setup_pt.tcl"; exit 1; \
	fi
	cd primetime/script && pt_shell -x '$(TCL_SET)' -f run_pt.tcl \
		| tee ../report/clk_$(CLK)/$(NET_TAG)/pt.log

apr: start
	cd apr/script && TOP=$(TOP) TECH=$(TECH) CLK=$(CLK) SCAN=$(SCAN) bash run_apr.sh

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

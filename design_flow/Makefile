# ============================================================
# IC Design Flow Makefile
# TECH : U18|TSMC13|ADFP|TN16|TN7
# CLK  : → clk_<CLK>/
# 網表 : 用指令區分（pt / pt_dft），內部傳 NET_TAG=syn|dft
# ============================================================

TOP      ?= DESIGN_TOP
TECH     ?= U18
CLK      ?= 10
NET_TAG  ?= syn          # 內部用；請改打 pt / pt_dft，不必手動設
RTL_FILE ?= rtl/src/$(TOP).v
TB_FILE  ?= sim/tb/tb_$(TOP).sv
FILELIST ?= rtl/filelist.f

SIM      ?= vcs
WORK     ?= work
TIMING   ?= 1
TECH_VERILOG ?= lib/$(TECH)/stdcell/typical.v

TCL_SET  = set TOP $(TOP); set TECH $(TECH); set CLK $(CLK); set NET_TAG $(NET_TAG)

GREEN := \033[0;32m
RED   := \033[0;31m
NC    := \033[0m

.PHONY: help start check_tech \
	sim sim_gate sim_gate_dft cov spyglass \
	syn syn_dft \
	lec lec_dft pt pt_dft tmax tmax_dft apr apr_dft \
	clean clean_all

help:
	@echo ""
	@echo "IC Design Flow (cwd = design_flow/)"
	@echo ""
	@echo "合成:"
	@echo "  make syn / syn_dft          CLK=10 TECH=U18"
	@echo ""
	@echo "後段（預設 = 無 scan；*_dft = 用 DFT 網表）:"
	@echo "  make lec / lec_dft"
	@echo "  make pt  / pt_dft"
	@echo "  make sim_gate / sim_gate_dft"
	@echo "  make tmax / tmax_dft"
	@echo "  make apr  / apr_dft"
	@echo ""
	@echo "常用:"
	@echo "  make syn CLK=10 && make pt CLK=10 && make lec CLK=10"
	@echo "  make syn_dft CLK=10 && make pt_dft CLK=10 && make tmax_dft CLK=10"
	@echo ""
	@echo "預設: TOP=$(TOP) TECH=$(TECH) CLK=$(CLK)"
	@echo ""

start:
	@mkdir -p $(WORK)/sim $(WORK)/sim_gate/clk_$(CLK)/$(NET_TAG)
	@mkdir -p syn/netlist/clk_$(CLK) syn/report/clk_$(CLK) syn/dft_report/clk_$(CLK)
	@mkdir -p sim/report/clk_$(CLK)/$(NET_TAG)
	@mkdir -p lec/report/clk_$(CLK)/$(NET_TAG) lec/session/clk_$(CLK)/$(NET_TAG)
	@mkdir -p tmax/report/clk_$(CLK)/$(NET_TAG) tmax/pattern/clk_$(CLK)/$(NET_TAG)
	@mkdir -p primetime/report/clk_$(CLK)/$(NET_TAG) apr/report/clk_$(CLK)/$(NET_TAG)
	@echo "$(GREEN)[INFO]$(NC) dirs ready  clk_$(CLK)/$(NET_TAG)"

check_tech:
	@if [ ! -d "lib/$(TECH)" ]; then \
		echo "$(RED)[ERROR]$(NC) 找不到製程目錄: lib/$(TECH)"; exit 1; \
	fi
	@echo "$(GREEN)[INFO]$(NC) TECH=$(TECH) CLK=$(CLK) NET_TAG=$(NET_TAG)"

# ---------- SIM ----------
sim: start
ifeq ($(SIM),vcs)
	vcs -full64 -sverilog -debug_access+all \
		-f $(FILELIST) $(TB_FILE) \
		-o $(WORK)/sim/simv
	./$(WORK)/sim/simv | tee $(WORK)/sim/sim.log
else
	xrun -sv -f $(FILELIST) $(TB_FILE) | tee $(WORK)/sim/sim.log
endif

sim_gate: NET_TAG=syn
sim_gate: start check_tech
	@chmod +x sim/script/run_sim_gate.sh
	TOP=$(TOP) TECH=$(TECH) CLK=$(CLK) NET_TAG=$(NET_TAG) SIM=$(SIM) \
	TIMING=$(TIMING) TECH_VERILOG=$(TECH_VERILOG) TB_FILE=$(TB_FILE) \
	bash sim/script/run_sim_gate.sh

sim_gate_dft: NET_TAG=dft
sim_gate_dft: start check_tech
	@chmod +x sim/script/run_sim_gate.sh
	TOP=$(TOP) TECH=$(TECH) CLK=$(CLK) NET_TAG=$(NET_TAG) SIM=$(SIM) \
	TIMING=$(TIMING) TECH_VERILOG=$(TECH_VERILOG) TB_FILE=$(TB_FILE) \
	bash sim/script/run_sim_gate.sh

cov: start
	cd cov/script && bash run_cov.sh $(TOP) $(SIM)

spyglass: start
	cd spyglass/script && sg_shell -x '$(TCL_SET)' -tcl run_spyglass.tcl

# ---------- SYN ----------
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

# ---------- LEC ----------
lec: NET_TAG=syn
lec: start check_tech
	cd lec/script && fm_shell -x '$(TCL_SET)' -f run_lec.tcl \
		| tee ../report/clk_$(CLK)/$(NET_TAG)/lec.log

lec_dft: NET_TAG=dft
lec_dft: start check_tech
	cd lec/script && fm_shell -x '$(TCL_SET)' -f run_lec.tcl \
		| tee ../report/clk_$(CLK)/$(NET_TAG)/lec.log

# ---------- PT ----------
pt: NET_TAG=syn
pt: start check_tech
	@if [ ! -f "lib/$(TECH)/setup_pt.tcl" ]; then \
		echo "$(RED)[ERROR]$(NC) 缺少 lib/$(TECH)/setup_pt.tcl"; exit 1; \
	fi
	cd primetime/script && pt_shell -x '$(TCL_SET)' -f run_pt.tcl \
		| tee ../report/clk_$(CLK)/$(NET_TAG)/pt.log

pt_dft: NET_TAG=dft
pt_dft: start check_tech
	@if [ ! -f "lib/$(TECH)/setup_pt.tcl" ]; then \
		echo "$(RED)[ERROR]$(NC) 缺少 lib/$(TECH)/setup_pt.tcl"; exit 1; \
	fi
	cd primetime/script && pt_shell -x '$(TCL_SET)' -f run_pt.tcl \
		| tee ../report/clk_$(CLK)/$(NET_TAG)/pt.log

# ---------- TMAX ----------
tmax: NET_TAG=syn
tmax: start
	cd tmax/script && TOP=$(TOP) TECH=$(TECH) CLK=$(CLK) NET_TAG=$(NET_TAG) tmax -shell run_tmax.tcl \
		| tee ../report/clk_$(CLK)/$(NET_TAG)/tmax.log

tmax_dft: NET_TAG=dft
tmax_dft: start
	cd tmax/script && TOP=$(TOP) TECH=$(TECH) CLK=$(CLK) NET_TAG=$(NET_TAG) tmax -shell run_tmax.tcl \
		| tee ../report/clk_$(CLK)/$(NET_TAG)/tmax.log

# ---------- APR ----------
apr: NET_TAG=syn
apr: start
	cd apr/script && TOP=$(TOP) TECH=$(TECH) CLK=$(CLK) NET_TAG=$(NET_TAG) bash run_apr.sh

apr_dft: NET_TAG=dft
apr_dft: start
	cd apr/script && TOP=$(TOP) TECH=$(TECH) CLK=$(CLK) NET_TAG=$(NET_TAG) bash run_apr.sh

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

# ============================================================
# IC Design Flow Makefile (方案 A)
# 流程: SIM → COV → SpyGlass → SYN → LEC → TMAX → PT → APR(Innovus)
# 路徑規則: 全部相對 design_flow/
# 製程切換: make syn TECH=U18
# ============================================================

# ---------- 使用者設定 ----------
TOP      ?= DESIGN_TOP
TECH     ?= U18          # U18 | TSMC13 | ADFP | TN16 | TN7
RTL_FILE ?= rtl/src/$(TOP).v
TB_FILE  ?= sim/tb/tb_$(TOP).sv
FILELIST ?= rtl/filelist.f

SIM      ?= vcs          # vcs | xrun
WORK     ?= work

# 傳入 EDA shell 的 TCL 變數
TCL_SET  = set TOP $(TOP); set TECH $(TECH)

GREEN := \033[0;32m
RED   := \033[0;31m
NC    := \033[0m

.PHONY: help start check_tech sim cov spyglass syn lec tmax pt apr clean clean_all

help:
	@echo ""
	@echo "IC Design Flow targets (cwd = design_flow/):"
	@echo "  make start       - 建立 work 目錄"
	@echo "  make sim         - RTL 功能模擬"
	@echo "  make cov         - Code Coverage"
	@echo "  make spyglass    - SpyGlass Lint + CDC"
	@echo "  make syn         - Design Compiler (compile_ultra)"
	@echo "  make lec         - Formality LEC"
	@echo "  make tmax        - TetraMAX ATPG"
	@echo "  make pt          - PrimeTime STA"
	@echo "  make apr         - Innovus APR"
	@echo "  make clean       - 清理 work / log"
	@echo ""
	@echo "製程切換 (TECH → lib/<TECH>/setup_*.tcl):"
	@echo "  make syn TECH=U18"
	@echo "  make syn TECH=TSMC13"
	@echo "  make syn TECH=ADFP"
	@echo "  make syn TECH=TN16"
	@echo "  make syn TECH=TN7"
	@echo "  make pt  TECH=U18     # 請與 syn 使用相同 TECH"
	@echo ""
	@echo "預設: TOP=$(TOP)  TECH=$(TECH)"
	@echo "路徑: 請維持相對路徑，勿改成絕對路徑"
	@echo ""

start:
	@mkdir -p $(WORK)/sim
	@mkdir -p syn/report lec/report tmax/report primetime/report apr/report spyglass/report cov/report
	@echo "$(GREEN)[INFO]$(NC) work/ and report dirs ready"

check_tech:
	@if [ ! -d "lib/$(TECH)" ]; then \
		echo "$(RED)[ERROR]$(NC) 找不到製程目錄: lib/$(TECH)"; \
		echo "        可用: U18 TSMC13 ADFP TN16 TN7 或自建 lib/<name>/"; \
		exit 1; \
	fi
	@echo "$(GREEN)[INFO]$(NC) TECH=$(TECH)  dir=lib/$(TECH)"

sim: start
ifeq ($(SIM),vcs)
	vcs -full64 -sverilog -debug_access+all \
		-f $(FILELIST) $(TB_FILE) \
		-o $(WORK)/sim/simv
	./$(WORK)/sim/simv | tee $(WORK)/sim/sim.log
else
	xrun -sv -f $(FILELIST) $(TB_FILE) | tee $(WORK)/sim/sim.log
endif

cov: start
	cd cov/script && bash run_cov.sh $(TOP) $(SIM)

spyglass: start
	cd spyglass/script && sg_shell -x '$(TCL_SET)' -tcl run_spyglass.tcl

syn: start check_tech
	@if [ ! -f "lib/$(TECH)/setup_dc.tcl" ]; then \
		echo "$(RED)[ERROR]$(NC) 缺少 lib/$(TECH)/setup_dc.tcl"; exit 1; \
	fi
	cd syn/script && dc_shell -x '$(TCL_SET)' -f run_syn.tcl | tee ../report/syn.log

lec: start check_tech
	cd lec/script && fm_shell -x '$(TCL_SET)' -f run_lec.tcl | tee ../report/lec.log

tmax: start
	cd tmax/script && tmax -shell run_tmax.tcl | tee ../report/tmax.log

pt: start check_tech
	@if [ ! -f "lib/$(TECH)/setup_pt.tcl" ]; then \
		echo "$(RED)[ERROR]$(NC) 缺少 lib/$(TECH)/setup_pt.tcl"; exit 1; \
	fi
	cd primetime/script && pt_shell -x '$(TCL_SET)' -f run_pt.tcl | tee ../report/pt.log

apr: start
	cd apr/script && TOP=$(TOP) bash run_apr.sh

clean:
	rm -rf $(WORK)
	rm -f syn/report/*.log lec/report/*.log tmax/report/*.log \
	      primetime/report/*.log apr/report/*.log

clean_all: clean
	@find syn/netlist syn/report lec/report lec/session \
	      tmax/report tmax/pattern primetime/report primetime/spef \
	      apr/def apr/gds apr/report cov/report spyglass/report \
	      -type f ! -name '.gitkeep' -delete 2>/dev/null || true
	@echo "$(GREEN)[INFO]$(NC) cleaned generated outputs"

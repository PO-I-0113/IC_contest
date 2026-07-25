# ============================================================
# IC Design Flow Makefile (方案 A)
# 流程: SIM → COV → SpyGlass → SYN → LEC → TMAX → PT → APR(Innovus)
# 路徑規則: 全部相對 design_flow/；各 TCL 會先 cd ../.. 再 source setup
# ============================================================

# ---------- 使用者設定 ----------
TOP      ?= DESIGN_TOP
RTL_FILE ?= rtl/src/$(TOP).v
TB_FILE  ?= sim/tb/tb_$(TOP).sv
FILELIST ?= rtl/filelist.f

SIM      ?= vcs          # vcs | xrun
WORK     ?= work

GREEN := \033[0;32m
NC    := \033[0m

.PHONY: help start sim cov spyglass syn lec tmax pt apr clean clean_all

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
	@echo "範例: make syn TOP=DESIGN_TOP"
	@echo "路徑: 請維持相對路徑，勿改成絕對路徑"
	@echo ""

start:
	@mkdir -p $(WORK)/sim
	@mkdir -p syn/report lec/report tmax/report primetime/report apr/report spyglass/report cov/report
	@echo "$(GREEN)[INFO]$(NC) work/ and report dirs ready"

# ---------- SIM（在 design_flow 根目錄用相對路徑）----------
sim: start
ifeq ($(SIM),vcs)
	vcs -full64 -sverilog -debug_access+all \
		-f $(FILELIST) $(TB_FILE) \
		-o $(WORK)/sim/simv
	./$(WORK)/sim/simv | tee $(WORK)/sim/sim.log
else
	xrun -sv -f $(FILELIST) $(TB_FILE) | tee $(WORK)/sim/sim.log
endif

# ---------- COV ----------
cov: start
	cd cov/script && bash run_cov.sh $(TOP) $(SIM)

# ---------- SpyGlass ----------
spyglass: start
	cd spyglass/script && sg_shell -tcl run_spyglass.tcl

# ---------- SYN ----------
syn: start
	cd syn/script && dc_shell -f run_syn.tcl | tee ../report/syn.log

# ---------- LEC ----------
lec: start
	cd lec/script && fm_shell -f run_lec.tcl | tee ../report/lec.log

# ---------- TMAX ----------
tmax: start
	cd tmax/script && tmax -shell run_tmax.tcl | tee ../report/tmax.log

# ---------- PrimeTime ----------
pt: start
	cd primetime/script && pt_shell -f run_pt.tcl | tee ../report/pt.log

# ---------- APR (Innovus) ----------
apr: start
	cd apr/script && bash run_apr.sh

# ---------- Clean ----------
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

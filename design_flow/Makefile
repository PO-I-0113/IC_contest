# ============================================================
# IC Design Flow Makefile (方案 A)
# 流程: SIM → COV → SpyGlass → SYN → LEC → TMAX → PT → APR
# ============================================================

# ---------- 使用者設定 ----------
TOP      ?= DESIGN_TOP
RTL_FILE ?= rtl/src/$(TOP).v
TB_FILE  ?= sim/tb/tb_$(TOP).sv
FILELIST ?= rtl/filelist.f

SIM      ?= vcs          # vcs | xrun
COV_DIR  ?= cov/report
WORK     ?= work

# ---------- 顏色（可選）----------
GREEN := \033[0;32m
NC    := \033[0m

.PHONY: help start sim cov spyglass syn lec tmax pt apr clean clean_all

help:
	@echo ""
	@echo "IC Design Flow targets:"
	@echo "  make start       - 建立 work 目錄"
	@echo "  make sim         - RTL 功能模擬"
	@echo "  make cov         - Code Coverage"
	@echo "  make spyglass    - SpyGlass Lint/CDC"
	@echo "  make syn         - Design Compiler 合成"
	@echo "  make lec         - Formality LEC"
	@echo "  make tmax        - TetraMAX ATPG"
	@echo "  make pt          - PrimeTime STA"
	@echo "  make apr         - APR (ICC2/Innovus)"
	@echo "  make clean       - 清理 work 與常見暫存"
	@echo ""
	@echo "變數範例: make sim TOP=REFRACT SIM=vcs"
	@echo ""

start:
	@mkdir -p $(WORK)
	@echo "$(GREEN)[INFO]$(NC) work/ ready"

# ---------- SIM ----------
sim: start
	@mkdir -p $(WORK)/sim
ifeq ($(SIM),vcs)
	cd $(WORK)/sim && vcs -full64 -sverilog -debug_access+all \
		-f ../../$(FILELIST) ../../$(TB_FILE) \
		-o simv && ./simv | tee sim.log
else
	cd $(WORK)/sim && xrun -sv -f ../../$(FILELIST) ../../$(TB_FILE) \
		| tee sim.log
endif

# ---------- COV ----------
cov: start
	@echo "$(GREEN)[INFO]$(NC) Run coverage script"
	cd cov/script && bash run_cov.sh $(TOP) $(SIM)

# ---------- SpyGlass ----------
spyglass:
	@echo "$(GREEN)[INFO]$(NC) Run SpyGlass"
	cd spyglass/script && sg_shell -tcl run_spyglass.tcl

# ---------- SYN ----------
syn:
	@echo "$(GREEN)[INFO]$(NC) Run Design Compiler"
	cd syn/script && dc_shell -f run_syn.tcl | tee ../report/syn.log

# ---------- LEC (Formality) ----------
lec:
	@echo "$(GREEN)[INFO]$(NC) Run Formality LEC"
	cd lec/script && fm_shell -f run_lec.tcl | tee ../report/lec.log

# ---------- TMAX ----------
tmax:
	@echo "$(GREEN)[INFO]$(NC) Run TetraMAX"
	cd tmax/script && tmax -shell run_tmax.tcl | tee ../report/tmax.log

# ---------- PrimeTime ----------
pt:
	@echo "$(GREEN)[INFO]$(NC) Run PrimeTime"
	cd primetime/script && pt_shell -f run_pt.tcl | tee ../report/pt.log

# ---------- APR ----------
apr:
	@echo "$(GREEN)[INFO]$(NC) Run APR"
	cd apr/script && bash run_apr.sh

# ---------- Clean ----------
clean:
	rm -rf $(WORK)
	rm -f syn/report/*.log lec/report/*.log tmax/report/*.log primetime/report/*.log

clean_all: clean
	rm -rf syn/netlist/* syn/report/* \
	       lec/report/* lec/session/* \
	       tmax/report/* tmax/pattern/* \
	       primetime/report/* primetime/spef/* \
	       apr/def/* apr/gds/* apr/report/* \
	       cov/report/* spyglass/report/*
	@# 保留 .gitkeep
	@find syn/netlist syn/report lec/report lec/session \
	      tmax/report tmax/pattern primetime/report primetime/spef \
	      apr/def apr/gds apr/report cov/report spyglass/report \
	      -name .gitkeep -prune -o -type f -exec rm -f {} + 2>/dev/null || true
	@echo "$(GREEN)[INFO]$(NC) cleaned generated outputs"

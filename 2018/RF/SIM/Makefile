# ==============================
#     File Path
# ==============================
TB_PATH = ./testfixture.v

NETLIST = ../syn_monitor_top/outputs/monitor_top_syn.v

#VERILOG_MODEL = /mnt2/TN7/PDK/IP/CBTK_TN7_core_TSMC_v1.0/orig_lib/TSMCHOME/digital/Front_End/verilog/tcbn07_bwph240l11p57pd_base_ulvt_130a/tcbn07_bwph240l11p57pd_base_ulvt.v

SDF_PATH = ../syn_monitor_top/outputs/monitor_top_syn.sdf

TOP_MODULE = RFILE
# ==============================
#     Define the simulator
# ==============================
VCS = vcs

SIM = ./simv
# ==============================
#     Define target-specific parameters
# ==============================
COMMON_PARAMS = -v +v2k -full64 -debug_acc+all -timescale=1ns/10ps +notimingcheck

DISABLE_TCHECK = +optconfigfile+no_tcheck.cfg +neg_tchk

SDF_OPTIONS = -sdf max:$(TOP_MODULE):$(SDF_PATH) +csdf+precompile +sdfverbose +neg_tchk

DEFINE_SET = +define+PAT3

DEFINE_SET_POS = +define+PAT1+GATE+ADFP
# code coverage option:  line+cond+fsm+branch+tgl
CM      = -cm line+cond+tgl+fsm
CM_DIR  = -cm_dir ./coverage_pat3.vdb
CM_EXCLUDE = -cm_hier coverage.cfg
COV_OPTIONS = $(CM) $(CM_DIR) $(CM_EXCLUDE)



env_set:
#verdi-vcs.cshrc generate waveform
#vcs.cshrc make vcs useful
	/bin/tcsh -c source /usr/cad/synopsys/CIC/verdi-vcs.cshrc; \
	/bin/tcsh -c source /usr/cad/synopsys/CIC/vcs.cshrc
# ==============================
#     Targets
# ==============================
# disable specific timing check based on the cfg file
vcs_disable_tcheck:
	$(VCS) $(COMMON_PARAMS) -l compile.log $(DEFINE_SET) $(SDF_OPTIONS) $(DISABLE_TCHECK) $(NETLIST) $(VERILOG_MODEL) $(TB_PATH)

sim_disable_tcheck: vcs_disable_tcheck
	$(SIM) -l sim.log

# check code coverage
vcs_rtl_cov:
	$(VCS) $(COMMON_PARAMS) -l compile.log $(DEFINE_SET) $(COV_OPTIONS)  $(TB_PATH)

sim_rtl_cov: vcs_rtl_cov
	$(SIM) -l sim.log $(COV_OPTIONS)

show_cov:
	verdi -cov -full64 -covdir *.vdb &

# basic compile and simulation rtl-sim
vcs_rtl:
	$(VCS)  $(COMMON_PARAMS) -l compile.log $(DEFINE_SET)  $(TB_PATH)
	
sim_rtl: vcs_rtl
	$(SIM) -l sim.log

# basic compile and simulation gate-level-sim
vcs_gate:
	$(VCS)  $(COMMON_PARAMS) -l compile.log $(DEFINE_SET_POS)  $(SDF_OPTIONS) $(TB_PATH)
	
sim_gate: vcs_gate
	$(SIM) -l sim.log




ncverilog_rtl:
	ncverilog testfixture.v +access+r +define+PAT1
	ncverilog testfixture.v +access+r +define+PAT2
	ncverilog testfixture.v +access+r +define+PAT3
ncverilog_gate:
	ncverilog testfixture.v +access+r +define+PAT1+GATE+ADFP

clean_all:
	rm -rf *xcelium*
	rm -rf simv csrc ucli.key vc_hdrs.h DVEfiles *.vpd *.key *.log *.daidir novas* *.history *conf
	rm -rf *fsdb* *vd* *nWave* sdf*
	rm -rf *.sdf.X*
	rm -rf *.txt*
	rm -rf INCA_libs


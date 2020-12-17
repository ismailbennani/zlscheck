include ../../config

FOLDERS = $(shell find ../misc/test_hyb_fad -type d)
SUTFILES = $(shell find ../misc/test_hyb_fad -name "*.ml")
SORTED = $(shell ocamldep -sort $(FOLDERS:%=-I %) $(SUTFILES))
CMXS = $(SORTED:.ml=.cmx)

INCLUDES += \
	-I $(CHECKLIB) zlscheck.cmxa \
	$(FOLDERS:%=-I %) $(notdir $(CMXS))

AT_INST1 = AT1_inst1 AT2_inst1 AT51_inst1 AT52_inst1 AT53_inst1 AT54_inst1 AT6a_inst1 AT6b_inst1 AT6c_inst1
AT_INST2 = AT1_inst2 AT2_inst2 AT51_inst2 AT52_inst2 AT53_inst2 AT54_inst2 AT6a_inst2 AT6b_inst2 AT6c_inst2
WT = WT1 WT2 WT3 WT4
CC = CC1 CC2 CC3 CC4 CC5
AFC = AFC27 AFC29 AFC33
BENCHES = $(AT_INST1) $(AT_INST2) $(WT) $(CC) $(AFC)

all: bench.opt

make_AT_inst1: $(AT_INST1:%=params_%)
make_AT_inst2: $(AT_INST2:%=params_%)
make_AT: make_AT_inst1 make_AT_inst2
make_WT: $(WT:%=params_%)
make_CC: $(CC:%=params_%)
make_AFC: $(AFC:%=params_%)
make_benches: make_AT make_WT

run_AT_inst1: $(AT_INST1:%=run_%)
run_AT_inst2: $(AT_INST2:%=run_%)
run_AT: run_AT_inst1 run_AT_inst2
run_WT: $(WT:%=run_%)
run_CC: $(CC:%=run_%)
run_AFC: $(AFC:%=run_%)
run_benches: run_AT run_WT

write_AT_inst1: $(AT_INST1:%=write_params_%)
write_AT_inst2: $(AT_INST2:%=write_params_%)
write_AT: write_AT_inst1 write_AT_inst2
write_WT: $(WT:%=write_params_%)
write_CC: $(CC:%=write_params_%)
write_AFC: $(AFC:%=write_params_%)
write_params: write_AT write_WT

%.opt: %.ml
	$(OCAMLOPT) -o $@ $(INCLUDES:.cma=.cmxa) $<

$(BENCHES:%=params_%): bench.opt
	./bench.opt make -v -o $@ -cmd ../bench.opt -time_limit 3600 -sut $(@:params_%=%)

$(BENCHES:%=run_%):
	cd $(@:run_%=params_%); smac --scenario scenario.txt

$(BENCHES:%=write_params_%):
	cd $(@:write_params_%=params_%); \
	../param_of_traj results/run_1/traj.json > param.ml

clean:
	rm -f param_config_space.pcs
	rm -f scenario.txt
	rm -f runhistory.json
	rm -f *.cm[iox] *.opt *.o

cleanall: clean
	rm -rf $(BENCHES:%=params_%) benchmarks train_params
	rm -f *.out

include ../../config

%.opt:%.ml
	$(OCAMLOPT) $(OCAMLOPTFLAGS:.cma=.cmxa) -o $@ $(INCLUDES:.cma=.cmxa) $<

ZELUCFLAGS += -I common -noreduce

INCLUDES += -I $(CHECKLIB) zlscheck.cma

DIRS = common $(shell find models -type d -mindepth 0 -maxdepth 1)

COMMON_ML = $(shell echo common/*.ml)
COMMON_MLI = $(shell echo common/*.mli)
COMMON_ZLS = $(shell echo common/*.zls)
COMMON_ZLI = $(shell echo common/*.zli)

BENCH_ML = $(shell echo *.ml)
BENCH_MLI = $(shell echo *.mli)

MLS = $(COMMON_ML) $(BENCH_ML)
MLIS = $(COMMON_MLI) $(BENCH_MLI)

INCLUDES += $(DIRS:%=-I %) \
\
myOp.cmx discrete_obs_fad.cmx zc.cmx zc_utils.cmx \
consts.cmx utils.cmx common.cmx common_myop.cmx \
autotransc.cmx autotransd.cmx autotransd_modes.cmx \
\
common_utils.cmx online.cmx offline.cmx replay.cmx bench_models.cmx replay_models.cmx

TARGET = run_bench.opt replay_bench.opt

all: $(TARGET)

run_bench.opt replay_bench.opt: INCLUDES += defbench.cmx
run_bench.opt replay_bench.opt: models defbench.cmx

common: $(COMMON_ML:.ml=.cmx) $(COMMON_ZLI:.zli=.zci) $(COMMON_ZLS:.zls=.cmx)

models: common
	$(MAKE) -C models

common/discrete_obs_fad.ml: common/discrete_obs_fad.zls common/myOp.zci
	$(ZELUC) $(ZELUCFLAGS) $<
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $@

clean_this:
	-cd common; rm -f *.cm[iox] *.o *.opt *.zci
	-rm -f *.cm[iox] *.o *.opt
	-rm common/discrete_obs_fad.ml

clean: clean_this
	$(MAKE) -C models clean

cleanall: clean_this
	$(MAKE) -C models cleanall

.depend:
	ocamldep $(INCLUDES) $(MLS) $(MLIS) > .depend
-include .depend

.PHONY: .depend models

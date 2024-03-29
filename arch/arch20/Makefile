include ../../config

%.opt:%.ml
	$(OCAMLOPT) $(OCAMLOPTFLAGS:.cma=.cmxa) -o $@ $(INCLUDES:.cma=.cmxa) $<

ZELUCFLAGS += -I common -noreduce

INCLUDES += -I $(CHECKLIB) zlscheck.cma

DIRS = common $(shell find models -mindepth 0 -maxdepth 1 -type d)

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
myOp.cmx discrete_obs_fad.cmx interp.cmx \
\
at_consts.cmx at_common.cmx autotransd.cmx \
\
constants.cmx matrix.cmx f16_types.cmx f16_mlutils.cmx f16_utils.cmx \
lowLevelController.cmx subf16_model.cmx gcasAutopilot.cmx \
\
cc_prop.cmx cc_d.cmx \
\
wt_common.cmx wt_params.cmx wt_d.cmx \
\
afc_delay.cmx afc_utils.cmx afc_d.cmx \
\
sc_utils.cmx sc_d.cmx \
\
nn_utils.cmx nn_d.cmx \
\
common_types.cmx common_utils.cmx online.cmx offline.cmx replay.cmx \
at_bench.cmx f16_bench.cmx cc_bench.cmx wt_bench.cmx afc_bench.cmx sc_bench.cmx \
nn_bench.cmx replay_models.cmx \
defbench.cmx

TARGET = run_bench.opt replay_bench.opt read_results.opt

all: $(TARGET)

run_bench.opt replay_bench.opt: models defbench.cmx

draw_at.opt draw_f16.opt draw_steamcondenser.opt: INCLUDES = graphics.cmxa

common: $(COMMON_ML:.ml=.cmx) $(COMMON_ZLI:.zli=.zci) $(COMMON_ZLS:.zls=.cmx)

models: common
	$(MAKE) -C models

common/common_types.cmx: common/myOp.cmx
common/interp.zci: common/myOp.zci
common/discrete_obs_fad.ml: common/discrete_obs_fad.zls common/myOp.zci
	$(ZELUC) $(ZELUCFLAGS) $<
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $@

clean_this:
	-cd common; rm -f *.cm[iox] *.o *.opt *.zci
	-rm -f *.cm[iox] *.o *.opt
	-rm common/discrete_obs_fad.ml
	-rm draw_at.opt

clean: clean_this
	$(MAKE) -C models clean

cleanall: clean_this
	$(MAKE) -C models cleanall

.depend:
	ocamldep $(INCLUDES) $(MLS) $(MLIS) > .depend
-include .depend

.PHONY: .depend models

include ../../config

MODELS = at f16 cc wt afc sc nn

ZELUCFLAGS += -I $(CHECKLIB) -I common $(MODELS:%=-I %)
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I common myOp.cmx

BENCH = at_bench f16_bench cc_bench wt_bench afc_bench sc_bench nn_bench

all: models $(BENCH:=.cmx) replay_models.cmx

$(BENCH:=.cmx): ZELUCFLAGS += -noreduce
$(BENCH:=.cmx): INCLUDES += $(MODELS:%=-I %)

$(BENCH:=.ml): $(BENCH:=.zls)
	$(ZELUC) $(ZELUCFLAGS) $(@:.ml=.zls)
	sed -i "s/Obj.magic ():MyOp.t Array.t/[|create(); create()|]/g" $@
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $@

replay_models.cmx: ZELUCFLAGS += -noreduce
replay_models.cmx: INCLUDES += $(MODELS:%=-I %)

replay_models.ml: replay_models.zls
	$(ZELUC) $(ZELUCFLAGS) $<
	sed -i "s/Obj.magic ():MyOp.t Array.t/[|create(); create()|]/g" $@
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $@

models: common
	for model in $(MODELS) ; do $(MAKE) -C $$model all ; done

# TMP

run_bench.opt: run_bench.ml
	ocamlopt -o run_bench.opt unix.cmxa \
		-I ../../external/zelus/lib zllib.cmxa \
		-I ../../external/fadbadml/lib/ fadbad.cmxa \
		-I ../../lib/ zlscheck.cmxa \
		-I common/ myOp.cmx discrete_obs_fad.cmx interp.cmx \
		-I at/ at_consts.cmx at_common.cmx autotransd.cmx at_bench.cmx \
		-I f16/ constants.cmx f16_types.cmx matrix.cmx f16_mlutils.cmx f16_utils.cmx \
			subf16_model.cmx lowLevelController.cmx gcasAutopilot.cmx \
			f16_bench.cmx \
		run_bench.ml




common:
	$(MAKE) -C common

clean_this:
	-rm -f $(BENCH:=.ml) $(BENCH:=.zci) $(BENCH:=.cm[iox]) $(BENCH:=.o)
	-rm -f run_bench.opt run_bench.zci run_bench.cm[iox] run_bench.o
	-rm -f replay_models.ml replay_models.zci replay_models.cm[iox] replay_models.o

cleanall realclean clean: clean_this
	for model in $(MODELS) ; do $(MAKE) -C $$model $@ ; done
	$(MAKE) -C common $@

.SECONDARY: $(BENCH:=.ml)
.PHONY: common

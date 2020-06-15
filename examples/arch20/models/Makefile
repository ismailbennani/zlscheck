include ../../../config

MODELS = at f16 cc wt afc

ZELUCFLAGS += -I $(CHECKLIB) -I ../common $(MODELS:%=-I %)
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../common myOp.cmx

BENCH = at_bench f16_bench cc_bench wt_bench afc_bench

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

models:
	for model in $(MODELS) ; do $(MAKE) -C $$model all ; done

clean_this:
	-rm -f $(BENCH:=.ml) $(BENCH:=.zci) $(BENCH:=.cm[iox]) $(BENCH:=.o)
	-rm -f replay_models.ml replay_models.zci replay_models.cm[iox] replay_models.o

cleanall: clean_this
	for model in $(MODELS) ; do $(MAKE) -C $$model cleanall ; done
realclean: clean_this
	for model in $(MODELS) ; do $(MAKE) -C $$model realclean ; done
clean: clean_this
	for model in $(MODELS) ; do $(MAKE) -C $$model clean ; done

.SECONDARY: $(BENCH:=.ml)

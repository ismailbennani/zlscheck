include ../../../config

MODELS = autotrans

ZELUCFLAGS += -I $(CHECKLIB) -I ../common $(MODELS:%=-I %)
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../common myOp.cmx

all: models bench_models.cmx replay_models.cmx

bench_models.cmx: ZELUCFLAGS += -noreduce
bench_models.cmx: INCLUDES += -I autotrans autotransd.cmx

bench_models.ml: bench_models.zls
	$(ZELUC) $(ZELUCFLAGS) $<
	sed -i "s/Obj.magic ():MyOp.t Array.t/[|create(); create()|]/g" $@
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $@

replay_models.cmx: ZELUCFLAGS += -noreduce
replay_models.cmx: INCLUDES += -I autotrans autotransd.cmx

replay_models.ml: replay_models.zls
	$(ZELUC) $(ZELUCFLAGS) $<
	sed -i "s/Obj.magic ():MyOp.t Array.t/[|create(); create()|]/g" $@
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $@

models:
	for model in $(MODELS) ; do $(MAKE) -C $$model all ; done

clean_this:
	-rm -f bench_models.ml bench_models.zci bench_models.cm[iox] bench_models.o
	-rm -f replay_models.ml replay_models.zci replay_models.cm[iox] replay_models.o

cleanall: clean_this
	for model in $(MODELS) ; do $(MAKE) -C $$model cleanall ; done
realclean: clean_this
	for model in $(MODELS) ; do $(MAKE) -C $$model realclean ; done
clean: clean_this
	for model in $(MODELS) ; do $(MAKE) -C $$model clean ; done

.SECONDARY: bench_models.ml

include ../../../config

MODELS = autotrans sanity_check

ZELUCFLAGS += -I $(CHECKLIB) -I ../common $(MODELS:%=-I %)
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../common myOp.cmx

all: models bench.cmx

bench.cmx: ZELUCFLAGS += -noreduce
bench.cmx: INCLUDES += -I autotrans autotransd.cmx -I sanity_check model.cmx

bench.ml: bench.zls
	$(ZELUC) $(ZELUCFLAGS) $<
	sed -i "s/Obj.magic ():MyOp.t Array.t/[|create(); create()|]/g" $@
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $@

models:
	for model in $(MODELS) ; do $(MAKE) -C $$model all ; done

clean_this:
	-rm -f bench.ml bench.zci bench.cm[iox] bench.o

cleanall: clean_this
	for model in $(MODELS) ; do $(MAKE) -C $$model cleanall ; done
realclean: clean_this
	for model in $(MODELS) ; do $(MAKE) -C $$model realclean ; done
clean: clean_this
	for model in $(MODELS) ; do $(MAKE) -C $$model clean ; done

.SECONDARY: bench.ml

include ../../../config

MODELS = at wt

ZELUCFLAGS += -copy -I $(CHECKLIB) -I common $(MODELS:%=-I %)
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I common myOp.cmx

BENCH = at_bench wt_bench

all: models $(BENCH:=.cmx)

$(BENCH:=.cmx): ZELUCFLAGS += -noreduce
$(BENCH:=.cmx): INCLUDES += $(MODELS:%=-I %)

$(BENCH:=.ml): $(BENCH:=.zls)
	$(ZELUC) $(ZELUCFLAGS) $(@:.ml=.zls)
	sed -i "s/Obj.magic ():MyOp.t Array.t/[|create(); create()|]/g" $@
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $@

models: common
	for model in $(MODELS) ; do $(MAKE) -C $$model all ; done

common:
	$(MAKE) -C common

clean_this:
	-rm -f $(BENCH:=.ml) $(BENCH:=.zci) $(BENCH:=.cm[iox]) $(BENCH:=.o)

cleanall realclean clean: clean_this
	for model in $(MODELS) ; do $(MAKE) -C $$model $@ ; done
	$(MAKE) -C common $@

.SECONDARY: $(BENCH:=.ml)
.PHONY: common

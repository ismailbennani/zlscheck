include ../../config

MODELS = at f16 cc wt afc sc nn

ZELUCFLAGS += -I $(CHECKLIB) -I common $(MODELS:%=-I %)
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I common

BENCH = at f16 cc wt afc sc nn

all: models $(BENCH:=.cmx) defsut.cmx

$(BENCH:=.cmx): ZELUCFLAGS += -noreduce
$(BENCH:=.cmx): INCLUDES += $(MODELS:%=-I %)

$(BENCH:=.ml): $(BENCH:=.zls)
	$(ZELUC) $(ZELUCFLAGS) $(@:.ml=.zls)
	sed -i "s/Obj.magic ():FadFloat.t Array.t/[|create(); create()|]/g" $@
	sed -i "s/Obj.magic ():FadFloat.t/create ():FadFloat.t/g" $@

models: common
	for model in $(MODELS) ; do $(MAKE) -C $$model all ; done

common:
	$(MAKE) -C common

clean_this:
	-rm -f $(BENCH:=.ml) $(BENCH:=.zci) $(BENCH:=.cm[iox]) $(BENCH:=.o)
	-rm -f defsut.cm[iox] defsut.o

cleanall realclean clean: clean_this
	for model in $(MODELS) ; do $(MAKE) -C $$model $@ ; done
	$(MAKE) -C common $@

.SECONDARY: $(BENCH:=.ml)
.PHONY: common

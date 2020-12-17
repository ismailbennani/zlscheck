include ../../../config

MODELS = at cc vdp

ZELUCFLAGS += -I $(CHECKLIB) -I common $(MODELS:%=-I %)
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I common $(MODELS:%=-I %)

BENCH = at cc vdp

all: models $(BENCH:=.cmx) defsut.cmx run_bench.opt

$(BENCH:=.cmx): ZELUCFLAGS += -noreduce

$(BENCH:=.ml): $(BENCH:=.zls)
	$(ZELUC) $(ZELUCFLAGS) $(@:.ml=.zls)
	sed -i "/^open FadFloat/d" $@
	sed -i "s/Ztypes/Ztypes_fad/g" $@
	sed -i "s/Zls/Zls_fad/g" $@
	sed -i "s/Fad_hacks.get//g" $@
	sed -i "s/Fad_hacks.make//g" $@
	sed -i "s/Zls_fad.set cstate\(.*\) 0./Zls_fad.set cstate\1 (FadFloat.create ())/g" $@
	sed -i "s/{ pos = 42.; der = 0. }/{ pos = FadFloat.integer 42; der = FadFloat.integer 0 }/g" $@
	sed -i "s/{ zin = false; zout = 1. }/{ zin = false; zout = FadFloat.make 1. }/g" $@
	sed -i "s/(\(.*\):float) = self.\(.*\).pos/(\1:FadFloat.t) = self.\2.pos/g" $@
	sed -i "s/Obj.magic ():FadFloat.t Array.t/[|FadFloat.create(); FadFloat.create()|]/g" $@
	sed -i "s/Obj.magic ():FadFloat.t/FadFloat.create ():FadFloat.t/g" $@

models: common
	for model in $(MODELS) ; do $(MAKE) -C $$model all ; done

common:
	$(MAKE) -C common

run_bench.opt: INCLUDES += discrete_obs_fad.cmx interp.cmx at_consts.cmx at_common.cmx  autotransc.cmx \
						   cc_c.cmx cc_prop.cmx cc.cmx \
						   vdp.cmx
run_bench.opt: at.cmx cc.cmx vdp.cmx defsut.cmx run_bench.ml
	$(OCAMLOPT) $(OCAMLOPTFLAGS) -o $@ \
	   $(ZLSTDLIBS:.cma=.cmxa) $(ZLEXTRALIBS:.cma=.cmxa) \
		 $(INCLUDES:.cma=.cmxa) $^

clean_this:
	-rm -f *.cm[iox] *.o *.opt
	-rm -f $(BENCH:=.ml) $(BENCH:=.zci) $(BENCH:=.cm[iox]) $(BENCH:=.o)

cleanall realclean clean: clean_this
	for model in $(MODELS) ; do $(MAKE) -C $$model $@ ; done
	$(MAKE) -C common $@

.SECONDARY: $(BENCH:=.ml)
.PHONY: common

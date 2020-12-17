include ../../../../config

.PHONY: test debug

OCAMLFLAGS += -I ../../../../lib -I ../common
OCAMLOPTFLAGS += -I ../../../../lib -I ../common
ZLEXTRALIBS = $(ZLGTKLIBS)
ZELUCFLAGS += -I ../../../../lib -I ../common

default: opt
all: opt
opt: autotransc.cmx autotransc.zci

# ------------------------------------

autotransc.opt: ZLEXTRALIBS = $(ZLGTKLIBS)
autotransc.opt: at_maneuvers.cmx at_consts.cmx at_common.cmx \
    		 autotransc.cmx autotransc_main.cmx
	$(OCAMLOPT) $(OCAMLOPTFLAGS) -o $@ \
	   $(ZLSTDLIBS:.cma=.cmxa) $(ZLEXTRALIBS:.cma=.cmxa) \
		 $(INCLUDES:.cma=.cmxa) $^

autotransc.ml: autotransc.zls at_common.zci at_maneuvers.zci
	$(ZELUC) $(ZELUCFLAGS) $(ZELUCEXTRAFLAGS) -noreduce $<
	sed -i "/^open FadFloat/d" $@
	sed -i "s/Ztypes/Ztypes_fad/g" $@
	sed -i "s/Zls/Zls_fad/g" $@
	sed -i "s/pos <- FadFloat.get /pos <-/g" $@
	sed -i "s/der <- FadFloat.get /der <-/g" $@
	sed -i "s/zout <- FadFloat.get /zout <-/g" $@
	sed -i "s/FadFloat.make //g" $@
	sed -i "s/Zls_fad.set cstate\(.*\) 0./Zls_fad.set cstate\1 (FadFloat.create ())/g" $@
	sed -i "s/{ pos = 42.; der = 0. }/{ pos = FadFloat.integer 42; der = FadFloat.integer 0 }/g" $@
	sed -i "s/{ zin = false; zout = 1. }/{ zin = false; zout = FadFloat.make 1. }/g" $@
	sed -i "s/(\(.*\):float) = self.\(.*\).pos/(\1:FadFloat.t) = self.\2.pos/g" $@
	# this should not have been programmed this way
	# currently, if you compile a hybrid node with static arguments: f s1 ... s2 ()
	# it is compiled into an ocaml function f cstate s1 ... s2 = ...
	# but when you call that node with solve: Node.solve (f s1 ... s2) ... 
	# the instanciation is compiled into Node.solve (f s1 ... s2) ... cstate 
	# the compiled ml function should be f s1 ... s2 cstate instead.
	sed -i "s/(cstate\(.*\))  \(.*\) =/\2 (cstate\1) =/g" $@

autotransc.cmx: at_common.cmx at_maneuvers.cmx

# ------------------------------------

at_common.ml: at_common.zls at_consts.zci at_consts.zci
	$(ZELUC) $(ZELUCFLAGS) $<

# ------------------------------------

at_common.cmx: at_consts.cmx

# ------------------------------------

%.zci %.ml: %.zls
	$(ZELUC) $(ZELUCFLAGS) $<

# ------------------------------------

clean:
	-@rm -f *.o *.cm[oix] *.annot *.obc *.zci

realclean cleanall: clean
	-@rm -f autotransc_main.ml autotransc.ml
	-@rm -f at_common.ml
	-@rm -f *.byte *.opt

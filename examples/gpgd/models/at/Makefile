include ../../../../config

ZELUCFLAGS += -copy -noreduce -I ../common
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../common myOp.cmx discrete_obs_fad.cmx

OBJ=autotransd.cmx

DEPS= at_consts.cmx at_common.cmx

all: $(OBJ)
opt: autotransd.opt

run_at_main.ml run_at.ml:
	$(ZELUC) $(ZELUCFLAGS) -o run_at_main -s main run_at.zls
	sed -i "s/Obj.magic ():MyOp.t Array.t/[|create(); create()|]/g" run_at.ml
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" run_at.ml
run_at.opt: INCLUDES += interp.cmx $(DEPS) autotransd.cmx
run_at.opt: $(DEPS) autotransd.cmx run_at_main.ml

# ------------------------------------

# autotransd.opt: ZLEXTRALIBS = $(ZLGTKLIBS)
autotransd.opt: INCLUDES += $(DEPS)
autotransd.opt: $(DEPS) autotransd_main.ml

autotransd_main.ml: autotransd.zls at_common.zci
	$(ZELUC) $(ZELUCFLAGS) -gtk2 -o autotransd_main -s main $<
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" autotransd.ml

autotransd.ml: autotransd.zls at_common.zci
	$(ZELUC) $(ZELUCFLAGS) $<
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" autotransd.ml
autotransd.cmx: at_common.cmx

# ------------------------------------

at_common.ml: at_consts.zci
	$(ZELUC) $(ZELUCFLAGS) $(@:.ml=.zls)
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $@
at_common.cmx: at_common.ml at_consts.cmx

# ------------------------------------

clean:
	-@rm -f autotransd_main.ml autotransd.ml
	-@rm -f at_common.ml
	-@rm -f run_at.ml run_at_main.ml run_at.opt
	-@rm -f *.o *.cm[oix] *.annot *.obc *.zci
	-@rm -f .depend

realclean cleanall: clean
	-@rm -f autotransd.opt
	-@rm -f autotransd_modes.opt

.depend: depend
depend: $(DEPS:.cmx=.ml) $(OBJ:.cmx=.ml)
	$(OCAMLDEP) -I ../common *.mli *.ml > .depend

-include .depend

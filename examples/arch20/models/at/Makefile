include ../../../../config

ZELUCFLAGS += -noreduce -I ../../common -I ../
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../ -I ../../common myOp.cmx discrete_obs_fad.cmx

OBJ=autotransd.cmx autotransd_modes.cmx

DEPS=at_utils.cmx consts.cmx common.cmx common_myop.cmx

all: $(OBJ)
opt: autotransd.opt

# ------------------------------------

# autotransd.opt: ZLEXTRALIBS = $(ZLGTKLIBS)
autotransd.opt: INCLUDES += $(DEPS:.cmx=.cmx)
autotransd.opt: $(DEPS:.cmx=.cmx) autotransd_main.ml

autotransd_main.ml: autotransd.zls common_myop.zci
	$(ZELUC) $(ZELUCFLAGS) -gtk2 -o autotransd_main -s main $<
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" autotransd.ml

autotransd.ml: autotransd.zls common_myop.zci
	$(ZELUC) $(ZELUCFLAGS) $<
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" autotransd.ml
autotransd.cmx: common_myop.cmx

# ------------------------------------

# autotransd_modes.opt: ZLEXTRALIBS = $(ZLGTKLIBS)
autotransd_modes.opt: INCLUDES += $(DEPS:.cmx=.cmx)
autotransd_modes.opt: $(DEPS:.cmx=.cmx) autotransd_modes_main.ml

autotransd_modes_main.ml: autotransd_modes.zls common_myop.zci
	$(ZELUC) $(ZELUCFLAGS) -gtk2 -o autotransd_modes_main -s main $<
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" autotransd_modes.ml

autotransd_modes.ml: autotransd_modes.zls common_myop.zci
	$(ZELUC) $(ZELUCFLAGS) $<
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" autotransd_modes.ml
autotransd_modes.cmx: common_myop.cmx

# ------------------------------------

common.ml common_myop.ml: consts.zci at_utils.zci
	$(ZELUC) $(ZELUCFLAGS) $(@:.ml=.zls)
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $@
common.cmx: common.ml consts.cmx at_utils.cmx
common_myop.cmx: common_myop.ml consts.cmx at_utils.cmx

# ------------------------------------

clean:
	-@rm -f autotransd_main.ml autotransd.ml
	-@rm -f autotransd_modes_main.ml autotransd_modes.ml
	-@rm -f common.ml common_myop.ml
	-@rm -f *.o *.cm[oix] *.annot *.obc *.zci

realclean cleanall: clean
	-@rm -f autotransd.opt
	-@rm -f autotransd_modes.opt

.depend: depend
depend: $(DEPS:.cmx=.ml) $(OBJ:.cmx=.ml)
	$(OCAMLDEP) $(INCLUDES) *.mli *.ml > .depend

-include .depend

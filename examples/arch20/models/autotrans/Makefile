include ../../../../config

ZELUCFLAGS += -noreduce -I ../../common -I ../
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../ -I ../../common myOp.cmx discrete_obs_fad.cmx

OBJ=autotransd_modes.cmx autotransd.cmx common.cmx consts.cmx utils.cmx

DEPS=utils.cmx consts.cmx common.cmx

all: $(OBJ)
opt: autotransd.opt

# ------------------------------------

# autotransd.opt: ZLEXTRALIBS = $(ZLGTKLIBS)
autotransd.opt: INCLUDES += $(DEPS:.cmx=.cmx)
autotransd.opt: $(DEPS:.cmx=.cmx) autotransd_main.ml

autotransd_main.ml: autotransd.zls common.zci
	$(ZELUC) $(ZELUCFLAGS) -gtk2 -o autotransd_main -s main $<
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" autotransd.ml

autotransd.ml: autotransd.zls common.zci
	$(ZELUC) $(ZELUCFLAGS) $<
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" autotransd.ml
autotransd.cmx: common.cmx

# ------------------------------------

# autotransd_modes.opt: ZLEXTRALIBS = $(ZLGTKLIBS)
autotransd_modes.opt: INCLUDES += $(DEPS:.cmx=.cmx)
autotransd_modes.opt: $(DEPS:.cmx=.cmx) autotransd_modes_main.ml

autotransd_modes_main.ml: autotransd_modes.zls common.zci
	$(ZELUC) $(ZELUCFLAGS) -gtk2 -o autotransd_modes_main -s main $<
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" autotransd_modes.ml

autotransd_modes.ml: autotransd_modes.zls common.zci
	$(ZELUC) $(ZELUCFLAGS) $<
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" autotransd_modes.ml
autotransd_modes.cmx: common.cmx

# ------------------------------------

common.ml: common.zls consts.zci utils.zci
common.cmx: consts.cmx utils.cmx

# ------------------------------------

export:
	mkdir $(DISTDIR)/autotrans
	cp consts.ml consts.zli utils.ml utils.zli common.zls\
		 autotrans.zls autotransd.zls Makefile $(DISTDIR)/autotrans/

clean:
	-@rm -f autotransc_main.ml autotransc.ml
	-@rm -f autotransd_main.ml autotransd.ml
	-@rm -f common.ml
	-@rm -f *.o *.cm[oix] *.annot *.obc *.zci

realclean cleanall: clean
	-@rm -f autotransc.opt
	-@rm -f autotransd.opt

.depend: depend
depend: $(OBJ:.cmx=.ml)
	$(OCAMLDEP) $(INCLUDES) *.mli *.ml > .depend

-include .depend

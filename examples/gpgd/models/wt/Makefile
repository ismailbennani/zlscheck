include ../../../../config

ZELUCFLAGS += -copy -noreduce -I ../common
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../common myOp.cmx

OBJ=wt_d.cmx

DEPS=wt_common.cmx wt_params.cmx
#
# wt_params.ml: wt_params.zls
# 	$(ZELUC) $(ZELUCFLAGS) $<
# 	sed -i "s/Obj.magic ():MyOp.t/MyOp.create ():MyOp.t/g" $@
#
# wt_common.ml: wt_common.zls
# 	$(ZELUC) $(ZELUCFLAGS) $<
# 	sed -i "s/Obj.magic ():MyOp.t/MyOp.create ():MyOp.t/g" $@

%_main.ml: %.zls
	$(ZELUC) $(ZELUCFLAGS) -s main -gtk2 -o $(@:.ml=) $<
	sed -i "s/Obj.magic ():MyOp.t/MyOp.create ():MyOp.t/g" $(@:_main.ml=.ml)
	sed -i "s/Obj.magic ():MyOp.t/MyOp.create ():MyOp.t/g" $@

# dependencies

all: wt_d.cmx

wt_d.opt: INCLUDES += $(DEPS)
wt_d.opt: wt_d_main.ml $(DEPS)
wt_d.cmx: $(DEPS)
wt_d.ml: $(DEPS:.cmx=.zci)
	$(ZELUC) $(ZELUCFLAGS) $(@:.ml=.zls)
	sed -i "s/Obj.magic ():MyOp.t/MyOp.create ():MyOp.t/g" $@

wt_params.cmx: wt_common.cmx

#

clean:
	-rm -f wt_d.ml wt_d_main.ml
	-rm -f wt_common.ml wt_params.ml
	-rm -rf *.annot *.zci *.cm[iox] *.o

cleanall realclean: clean
	-rm -rf *.byte *.opt *.out

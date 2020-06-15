include ../../../../config

ZELUCFLAGS += -noreduce -I ../../common -I ../
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../ -I ../../common myOp.cmx

OBJ=wt_d.cmx

DEPS=wt_interp.cmx wt_common.cmx wt_params.cmx

%_main.ml: %.zls
	$(ZELUC) $(ZELUCFLAGS) -s main -gtk2 -o $(@:.ml=) $<
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $(@:_main.ml=.ml)
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $@

# dependencies

all: wt_d.cmx

wt_d.opt: INCLUDES += $(DEPS)
wt_d.opt: wt_d_main.ml $(DEPS)
wt_d.cmx: $(DEPS)
wt_d.ml: $(DEPS:.cmx=.zci)

wt_interp.zci: array.zci
wt_params.zci: array.zci wt_common.zci
wt_params.cmx: wt_common.cmx
wt_common.zci: wt_interp.zci
wt_common.cmx: wt_interp.cmx

#

clean:
	-rm -f wt_d.ml wt_d_main.ml
	-rm -f wt_common.ml wt_params.ml
	-rm -rf *.annot *.zci *.cm[iox] *.o

cleanall realclean: clean
	-rm -rf *.byte *.opt *.out

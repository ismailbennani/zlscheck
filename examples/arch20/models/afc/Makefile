include ../../../../config

ZELUCFLAGS += -noreduce -I ../../common -I ../
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../ -I ../../common myOp.cmx

OBJ=afc_d.cmx

DEPS=afc_interp.cmx afc_delay.cmx afc_utils.cmx

%_main.ml: %.zls
	$(ZELUC) $(ZELUCFLAGS) -s main -o $(@:.ml=) $<
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $(@:_main.ml=.ml)
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $@

# dependencies

all: afc_d.cmx

afc_d.opt: INCLUDES += $(DEPS)
afc_d.opt: afc_d_main.ml $(DEPS)
afc_d.cmx: $(DEPS)
afc_d.ml: $(DEPS:.cmx=.zci)

afc_utils.zci afc_utils.ml: afc_interp.zci afc_delay.zci
afc_utils.cmx: afc_interp.cmx afc_delay.cmx

#

clean:
	-rm -f afc_d.ml afc_d_main.ml
	-rm -f afc_utils.ml
	-rm -rf *.annot *.zci *.cm[iox] *.o

cleanall realclean: clean
	-rm -rf *.byte *.opt *.out

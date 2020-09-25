include ../../../config

ZELUCFLAGS += -noreduce -I ../common
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../common myOp.cmx discrete_obs_fad.cmx

OBJ=nn_d.cmx

%_main.ml: %.zls
	$(ZELUC) $(ZELUCFLAGS) -s main -gtk2 -o $(@:.ml=) $<
	sed -i "s/Obj.magic ():MyOp.t/MyOp.create ():MyOp.t/g" $(@:_main.ml=.ml)
	sed -i "s/Obj.magic ():MyOp.t/MyOp.create ():MyOp.t/g" $@

# dependencies

all: nn_d.cmx

DEPS = nn_utils.cmx

nn_d.opt nn_d.cmx: INCLUDES += $(DEPS)
nn_d.opt: nn_d_main.ml $(DEPS)
nn_d.ml: $(DEPS:.cmx=.zci)
nn_d.cmx: $(DEPS)

#

clean:
	-rm -f nn_d.ml nn_d_main.ml
	-rm -f nn_utils.ml
	-rm -rf *.annot *.zci *.cm[iox] *.o

cleanall realclean: clean
	-rm -rf *.byte *.opt *.out

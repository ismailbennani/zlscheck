include ../../../config

ZELUCFLAGS += -noreduce -I ../common -I $(CHECKLIB)
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../common

# dependencies

all: cc_d.ml cc_d.cmx cc_prop.cmx cc_prop.zci

cc_d.opt: ZELUCFLAGS += -gtk2 -s main -o cc_d_main
cc_d.opt: ZLEXTRALIBS=$(ZLGTKLIBS)

#

clean:
	-rm -f cc_d.ml cc_d_main.ml
	-rm -rf *.annot *.zci *.cm[iox] *.o

cleanall realclean: clean
	-rm -rf *.byte *.opt *.out

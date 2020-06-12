include ../../../../config

ZELUCFLAGS += -noreduce -I ../../common -I ../
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../ -I ../../common myOp.cmx

# dependencies

all: cc_d.cmx cc_c.cmx dcc_c.cmx

cc_d.opt: ZELUCFLAGS += -gtk2 -s main -o cc_d_main
cc_c.opt: ZELUCFLAGS += -gtk2 -s main -o cc_c_main
dcc_c.opt: ZELUCFLAGS += -gtk2 -s main -o dcc_c_main
cc_d.opt cc_c.opt dcc_c.opt: ZLEXTRALIBS=$(ZLGTKLIBS)

#

clean:
	-rm -f cc_d.ml cc_d_main.ml
	-rm -f cc_c.ml cc_c_main.ml
	-rm -f dcc_c.ml dcc_c_main.ml
	-rm -rf *.annot *.zci *.cm[iox] *.o

cleanall realclean: clean
	-rm -rf *.byte *.opt *.out

include ../../../../config

ZELUCFLAGS += -I ../../common
OCAMLOPTFLAGS += -I ../../common

all: sanity_check.cmx

sanity_check.ml:sanity_check.zls
	$(ZELUC) $(ZELUCFLAGS) $<
	# sed -i "s/Obj.magic ():MyOp.t Array.t/[|MyOp.create ();MyOp.create ()|]:MyOp.t Array.t/g" $@

clean cleanall:
	 -rm -f *.ml *.cm[iox] *.o *.zci

.SECONDARY: sanity_check.ml

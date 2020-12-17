include ../../../../config

ZELUCFLAGS += -noreduce -I ../common -I $(CHECKLIB)
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../common

# dependencies

all: cc_c.cmx cc_c.zci cc_prop.zci cc_prop.cmx

cc_c.ml: cc_c.zls 
	$(ZELUC) $(ZELUCFLAGS) $(ZELUCEXTRAFLAGS) -noreduce $<
	sed -i "/^open FadFloat/d" $@
	sed -i "s/Ztypes/Ztypes_fad/g" $@
	sed -i "s/Zls/Zls_fad/g" $@
	sed -i "s/pos <- FadFloat.get /pos <-/g" $@
	sed -i "s/der <- FadFloat.get /der <-/g" $@
	sed -i "s/zout <- FadFloat.get /zout <-/g" $@
	sed -i "s/FadFloat.make //g" $@
	sed -i "s/Obj.magic ():FadFloat.t/FadFloat.create ():FadFloat.t/g" $@
	sed -i "s/Zls_fad.set cstate\(.*\) 0./Zls_fad.set cstate\1 (FadFloat.create ())/g" $@
	sed -i "s/{ pos = 42.; der = 0. }/{ pos = FadFloat.integer 42; der = FadFloat.integer 0 }/g" $@
	sed -i "s/{ zin = false; zout = 1. }/{ zin = false; zout = FadFloat.make 1. }/g" $@
	sed -i "s/(\(.*\):float) = self.\(.*\).pos/(\1:FadFloat.t) = self.\2.pos/g" $@

cc_c.opt: cc_c_main.ml
cc_c_main.ml: cc_c.zls
	$(ZELUC) $(ZELUCFLAGS) $(ZELUCEXTRAFLAGS) -noreduce -gtk2 -s main -o cc_c_main $<
	sed -i "/^open FadFloat/d" cc_c.ml
	sed -i "s/Ztypes/Ztypes_fad/g" cc_c.ml
	sed -i "s/Zls/Zls_fad/g" cc_c.ml
	sed -i "s/pos <- FadFloat.get /pos <-/g" cc_c.ml
	sed -i "s/der <- FadFloat.get /der <-/g" cc_c.ml
	sed -i "s/zout <- FadFloat.get /zout <-/g" cc_c.ml
	sed -i "s/FadFloat.make //g" cc_c.ml
	sed -i "s/Obj.magic ():FadFloat.t/FadFloat.create ():FadFloat.t/g" cc_c.ml
	sed -i "s/Zls_fad.set cstate\(.*\) 0./Zls_fad.set cstate\1 (FadFloat.create ())/g" cc_c.ml
	sed -i "s/{ pos = 42.; der = 0. }/{ pos = FadFloat.integer 42; der = FadFloat.integer 0 }/g" cc_c.ml
	sed -i "s/{ zin = false; zout = 1. }/{ zin = false; zout = FadFloat.make 1. }/g" cc_c.ml
	sed -i "s/(\(.*\):float) = self.\(.*\).pos/(\1:FadFloat.t) = self.\2.pos/g" cc_c.ml

#

clean:
	-rm -f cc_c.ml cc_c_main.ml
	-rm -rf *.annot *.zci *.cm[iox] *.o

cleanall realclean: clean
	-rm -rf *.byte *.opt *.out

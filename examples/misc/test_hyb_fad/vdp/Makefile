include ../../../../config

ZELUCFLAGS += -noreduce -I ../common -I $(CHECKLIB)
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../common

# dependencies

all: van_der_pol.cmx van_der_pol.zci

van_der_pol.ml: van_der_pol.zls 
	$(ZELUC) $(ZELUCFLAGS) $(ZELUCEXTRAFLAGS) -noreduce $<
	sed -i "/^open FadFloat/d" $@
	sed -i "s/Ztypes/Ztypes_fad/g" $@
	sed -i "s/Zls/Zls_fad/g" $@
	sed -i "s/Fad_hacks.get//g" $@
	sed -i "s/Fad_hacks.make//g" $@
	sed -i "s/Obj.magic ():FadFloat.t/FadFloat.create ():FadFloat.t/g" $@
	sed -i "s/Zls_fad.set cstate\(.*\) 0./Zls_fad.set cstate\1 (FadFloat.create ())/g" $@
	sed -i "s/{ pos = 42.; der = 0. }/{ pos = FadFloat.integer 42; der = FadFloat.integer 0 }/g" $@
	sed -i "s/{ zin = false; zout = 1. }/{ zin = false; zout = FadFloat.make 1. }/g" $@
	sed -i "s/(\(.*\):float) = self.\(.*\).pos/(\1:FadFloat.t) = self.\2.pos/g" $@

van_der_pol.opt: van_der_pol_main.ml
van_der_pol_main.ml: van_der_pol.zls
	$(ZELUC) $(ZELUCFLAGS) $(ZELUCEXTRAFLAGS) -noreduce -gtk2 -s main -o van_der_pol_main $<
	sed -i "/^open FadFloat/d" van_der_pol.ml
	sed -i "s/Ztypes/Ztypes_fad/g" van_der_pol.ml
	sed -i "s/Zls/Zls_fad/g" van_der_pol.ml
	sed -i "s/Fad_hacks.get//g" van_der_pol.ml
	sed -i "s/Fad_hacks.make//g" van_der_pol.ml
	sed -i "s/Obj.magic ():FadFloat.t/FadFloat.create ():FadFloat.t/g" van_der_pol.ml
	sed -i "s/Zls_fad.set cstate\(.*\) 0./Zls_fad.set cstate\1 (FadFloat.create ())/g" van_der_pol.ml
	sed -i "s/{ pos = 42.; der = 0. }/{ pos = FadFloat.integer 42; der = FadFloat.integer 0 }/g" van_der_pol.ml
	sed -i "s/{ zin = false; zout = 1. }/{ zin = false; zout = FadFloat.make 1. }/g" van_der_pol.ml
	sed -i "s/(\(.*\):float) = self.\(.*\).pos/(\1:FadFloat.t) = self.\2.pos/g" van_der_pol.ml

#

clean:
	-rm -f van_der_pol.ml van_der_pol_main.ml
	-rm -rf *.annot *.zci *.cm[iox] *.o

cleanall realclean: clean
	-rm -rf *.byte *.opt *.out

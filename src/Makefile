include ../config

dirs = $(shell find * -type d)
OCAMLFLAGS += -I `ocamlfind query sundialsml` sundials.cma
OCAMLOPTFLAGS += -I `ocamlfind query sundialsml` sundials.cmxa
INCLUDES += $(dirs:%=-I %)
ZELUCFLAGS += $(dirs:%=-I %)

# find all .ml files in subdirectories
ml = $(shell find * -name "*.ml")

sorted_ml = $(shell ocamldep -sort $(ml))
cmx = $(sorted_ml:.ml=.cmx)
cmo = $(sorted_ml:.ml=.cmo)

# find all .zls files in subdirectories
zls = $(shell find * -name "*.zls")
zli = $(shell find * -name "*.zli")

zls_ml = $(zls:.zls=.ml)

libs = zlscheck.cmxa zlscheck.cma

all: $(libs)

mls: $(zls_ml)

cmxs: $(zls_ml) $(zli:.zli=.zci)
	$(MAKE) $(ml:.ml=.cmx)
cmos: $(zls_ml) $(zli:.zli=.zci)
	$(MAKE) $(ml:.ml=.cmo)

# zlscheck

zlscheck.cmxa: cmxs
	cp $(shell find * -mindepth 1 -name "*.cmi") \
	   $(shell find * -mindepth 1 -name "*.zci") .
	@# build .cmxa
	ocamlopt -a -opaque $(OCAMLOPTFLAGS) -o $@ $(dirs:%=-I %) \
		$(notdir $(sorted_ml:.ml=.cmx))

zlscheck.cma: cmos
	cp $(shell find * -mindepth 1 -name "*.cmi") \
	   $(shell find * -mindepth 1 -name "*.zci") .
	@# build .cmoa
	ocamlc -a -opaque $(OCAMLOPTFLAGS) -o $@ $(dirs:%=-I %) \
		$(notdir $(sorted_ml:.ml=.cmo))

clean cleanall:
	-find * -type f -name "*.zci" -delete
	-find * -type f -name "*.cm[iox]" -delete
	-find * -type f -name "*.cm[x]a" -delete
	-find * -type f -name "*.[ao]" -delete

-include .zlsdeps
-include .depend

make_depend:
	ocamldep $(dirs:%=-I %) $(shell find * -name "*.ml") > .depend

.PHONY: .zlsdeps .depend

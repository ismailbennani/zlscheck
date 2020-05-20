include ../config

dirs = $(shell find * -type d)
INCLUDES += $(dirs:%=-I %) fadbad.cma
ZELUCFLAGS += $(dirs:%=-I %)

# find all .ml files in subdirectories
ml = $(shell find * -mindepth 2 -name "*.ml")

sorted_ml = $(shell ocamldep -sort $(ml))
cmx = $(sorted_ml:.ml=.cmx)
cmo = $(sorted_ml:.ml=.cmo)

# find all .zls files in subdirectories
zls = $(shell find * -mindepth 2 -name "*.zls")
zli = $(shell find * -mindepth 2 -name "*.zli")

zls_ml = $(zls:.zls=.ml)

libs = zlscheck.cmxa zlscheck.cma zlfalsif.cmxa zlfalsif.cma

all: $(libs)

mls: $(zls_ml)

cmxs: $(zls_ml) $(zli:.zli=.zci)
	$(MAKE) $(ml:.ml=.cmx)
cmos: $(zls_ml) $(zli:.zli=.zci)
	$(MAKE) $(ml:.ml=.cmo)

# zlscheck

zlscheck.cmxa: cmxs
	cp $(shell find * -mindepth 2 -name "*.cmx") \
	   $(shell find * -mindepth 2 -name "*.cmi") \
	   $(shell find * -mindepth 2 -name "*.zci") \
   	   $(shell find * -mindepth 2 -name "*.o") .
	@# build .cmxa
	ocamlopt -a -o $@ \
		$(notdir $(sorted_ml:.ml=.cmx)) zlscheck.ml

zlscheck.cma: cmos
	cp $(shell find * -mindepth 2 -name "*.cmo") \
	   $(shell find * -mindepth 2 -name "*.cmi") \
	   $(shell find * -mindepth 2 -name "*.zci") .
	@# build .cmoa
	ocamlc -a -o $@ \
		$(notdir $(sorted_ml:.ml=.cmo)) zlscheck.ml

# zlfalsif

DIR = core/spec/obs
OBJ = assert discrete_obs hybrid_obs dual gen

zlfalsif.cmxa: $(OBJ:%=$(DIR)/%.zci) $(OBJ:%=$(DIR)/%.cmx)
	cd $(DIR); ocamlopt -a -o $@ $(OBJ:=.cmx)
zlfalsif.cma: $(OBJ:%=$(DIR)/%.zci) $(OBJ:%=$(DIR)/%.cmo)
	cd $(DIR); ocamlc -a -o $@ $(OBJ:=.cmo)

clean cleanall:
	-find * -type f -name "*.zci" -delete
	-find * -type f -name "*.cm[iox]" -delete
	-find * -type f -name "*.cm[x]a" -delete
	-find * -type f -name "*.[ao]" -delete
	-rm -f $(zls_ml)

-include .zlsdeps
-include .depend

make_depend:
	ocamldep $(INCLUDES) $(shell find * -name "*.ml") > .depend

.PHONY: .zlsdeps .depend

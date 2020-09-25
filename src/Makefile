include ../config

dirs = $(shell find * -type d)
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
	   $(shell find * -mindepth 1 -name "*.zci") \
   	   $(shell find * -mindepth 1 -name "*.o") .
	@# build .cmxa
	ocamlopt -a -o $@ $(dirs:%=-I %) \
		$(notdir $(sorted_ml:.ml=.cmx))

zlscheck.cma: cmos
	cp $(shell find * -mindepth 1 -name "*.cmi") \
	   $(shell find * -mindepth 1 -name "*.zci") .
	@# build .cmoa
	ocamlc -a -o $@ $(dirs:%=-I %) \
		$(notdir $(sorted_ml:.ml=.cmo))

# zlfalsif

# DIR = core/spec/obs
# OBJ = assert discrete_obs hybrid_obs dual gen
#
# $(DIR)/dual.cmx: core/spec/obs/assert.cmx
#
# zlfalsif.cmxa: $(OBJ:%=$(DIR)/%.zci) $(OBJ:%=$(DIR)/%.cmx)
# 	cd $(DIR); ocamlopt -a -o $@ $(OBJ:=.cmx)
# zlfalsif.cma: $(OBJ:%=$(DIR)/%.zci) $(OBJ:%=$(DIR)/%.cmo)
# 	cd $(DIR); ocamlc -a -o $@ $(OBJ:=.cmo)

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

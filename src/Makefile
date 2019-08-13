include ../config

INCLUDES += -I $(shell zeluc -where)

dirs = $(shell find * -type d)
INCLUDES += $(dirs:%=-I %)

# find all .ml files in subdirectories
ml = $(shell find * -name "*.ml")

sorted_ml = $(shell ocamldep -sort $(ml))
cmo = $(sorted_ml:.ml=.cmo)

lib = zlscheck.cma

all: $(lib)
	@mkdir -p ../lib
	@# copy all .cmi files in subdirectories to lib
	find * -mindepth 2 -name "*.cmi" -exec cp -t ../lib {} +
	@# copy .cma to lib
	cp -f $(lib) ../lib


$(lib): $(cmo)
	@# build .cma
	ocamlc -a -o $(lib) \
		$(INCLUDES) \
		$(cmo)

# CLEANING STUFF

clean:
	-@find * -mindepth 2 -name "*.cm[xoia]" -delete
	-@rm .depend
realclean cleanall: clean
	-@find * -name "*.cm[xoia]" -delete

-include .depend
.depend:
	-@ocamldep $(INCLUDES) $(shell find * -name "*.ml") > .depend

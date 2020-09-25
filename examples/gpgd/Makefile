include ../../config

MODEL_FOLDERS = $(shell find models -type d)

INCLUDES += graphics.cmxa -I $(CHECKLIB) zlscheck.cmxa \
$(MODEL_FOLDERS:%=-I %) \
\
myOp.cmx discrete_obs_fad.cmx interp.cmx \
\
at_consts.cmx at_common.cmx autotransd.cmx \
\
wt_common.cmx wt_params.cmx wt_d.cmx \
\
common_types.cmx \
at_bench.cmx wt_bench.cmx\
defbench.cmx

all: run_bench.opt

run_bench.opt: run_bench.cmx
	$(OCAMLOPT) -o $@ $(OCAMLOPTFLAGS:.cma=.cmxa) $(INCLUDES:.cma=.cmxa) $^
run_bench.cmx: models

models:
	$(MAKE) -C models

clean:
	-rm -f run_bench.cmi run_bench.cmx run_bench.o run_bench.opt
	-rm -f bench_type.cmi bench_type.cmx bench_type.o
	-rm -f defbench.cmi defbench.cmx defbench.o
	$(MAKE) -C models clean

.depend:
	ocamldep *.ml *.mli > .depend
include .depend

.PHONY: models .depend

include ../../../config

ZELUCFLAGS += -noreduce -I ../common -I $(CHECKLIB)
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../common discrete_obs_fad.cmx

all: controlledf16.cmx
opt: run_controlledf16.opt

%.opt: ZLEXTRALIBS=$(ZLGTKLIBS)
%.opt: ZELUCFLAGS+=-gtk2
%.opt: %.ml
	$(OCAMLOPT) $(OCAMLOPTFLAGS) -o $@ \
	    -I $(ZLLIB) $(ZLSTDLIBS:.cma=.cmxa) $(ZLEXTRALIBS:.cma=.cmxa) \
			$(INCLUDES:.cma=.cmxa) \
	    $< $(<:.ml=_main.ml)

%_main.ml: %.zls
	$(ZELUC) -s main $(ZELUCFLAGS) -o $(@:.ml=) $<

# dependencies

f16_mlutilsDeps = constants.cmx matrix.cmx
f16_mlutils.ml: $(f16_mlutilsDeps:.cmx=.zci)
f16_mlutils.cmx: $(f16_mlutilsDeps)

f16_utilsDeps = constants.cmx matrix.cmx f16_mlutils.cmx
f16_utils.ml: $(f16_utilsDeps:.cmx=.zci)
f16_utils.cmx: $(f16_utilsDeps)

subf16_modelDeps = constants.cmx f16_types.cmx f16_mlutils.cmx f16_utils.cmx
subf16_model.ml: $(subf16_modelDeps:.cmx=.zci)
subf16_model.cmx: $(subf16_modelDeps)

lowLevelControllerDeps = constants.cmx f16_types.cmx matrix.cmx f16_mlutils.cmx \
						 f16_utils.cmx
lowLevelController.ml: $(lowLevelControllerDeps:.cmx=.zci)
lowLevelController.cmx: $(lowLevelControllerDeps)

gcasAutopilotDeps = constants.cmx f16_mlutils.cmx f16_utils.cmx f16_types.cmx
gcasAutopilot.ml: $(gcasAutopilotDeps:.cmx=.zci)
gcasAutopilot.cmx: $(gcasAutopilotDeps)

controlledf16Deps = constants.cmx f16_types.cmx gcasAutopilot.cmx \
					lowLevelController.cmx subf16_model.cmx
controlledf16.ml: $(controlledf16Deps:.cmx=.zci)
controlledf16.cmx: $(controlledf16Deps)

run_controlledf16Deps = constants.cmx f16_types.cmx matrix.cmx f16_mlutils.cmx f16_utils.cmx gcasAutopilot.cmx \
											 lowLevelController.cmx subf16_model.cmx \
											 controlledf16.cmx
run_controlledf16.ml run_controlledf16_main.ml: $(run_controlledf16Deps:.cmx=.zci)
run_controlledf16.cmx: $(run_controlledf16Deps)
run_controlledf16.opt: INCLUDES += $(run_controlledf16Deps:.cmx=.cmx)
run_controlledf16.opt: $(run_controlledf16Deps:.cmx=.cmx) run_controlledf16_main.ml

run_subf16_modelDeps = constants.cmx f16_types.cmx matrix.cmx f16_mlutils.cmx f16_utils.cmx \
											 subf16_model.cmx
run_subf16_model.ml run_subf16_model_main.ml: $(run_subf16_modelDeps:.cmx=.zci)
run_subf16_model.cmx: $(run_subf16_modelDeps)
run_subf16_model.opt: INCLUDES += $(run_subf16_modelDeps:.cmx=.cmx)
run_subf16_model.opt: $(run_subf16_modelDeps:.cmx=.cmx) run_subf16_model_main.ml

clean:
	-rm -rf f16_types.ml constants.ml f16_utils.ml
	-rm -rf lowLevelController.ml
	-rm -rf gcasAutopilot.ml
	-rm -rf controlledf16.ml
	-rm -rf subf16_model.ml
	-rm -rf run_subf16_model.ml run_subf16_model_main.ml
	-rm -rf run_controlledf16.ml run_controlledf16_main.ml
	-rm -rf *.annot *.zci *.cm[iox] *.o

cleanall realclean: clean
	-@rm -rf *.byte *.opt *.out

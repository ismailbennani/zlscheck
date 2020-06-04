include ../../../../config

ZELUCFLAGS += -noreduce -I ../../common -I ../
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa -I ../ -I ../../common myOp.cmx discrete_obs_fad.cmx

default: run_controlledf16.opt

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

utilsDeps = constants.cmx matrix.cmx mlutils.cmx
utils.ml: $(utilsDeps:.cmx=.zci)
utils.cmx: $(utilsDeps)

subf16_modelDeps = constants.cmx types.cmx mlutils.cmx utils.cmx
subf16_model.ml: $(subf16_modelDeps:.cmx=.zci)
subf16_model.cmx: $(subf16_modelDeps)

lowLevelControllerDeps = constants.cmx types.cmx matrix.cmx mlutils.cmx utils.cmx
lowLevelController.ml: $(lowLevelControllerDeps:.cmx=.zci)
lowLevelController.cmx: $(lowLevelControllerDeps)

gcasAutopilotDeps = constants.cmx mlutils.cmx utils.cmx types.cmx
gcasAutopilot.ml: $(gcasAutopilotDeps:.cmx=.zci)
gcasAutopilot.cmx: $(gcasAutopilotDeps)

controlledf16Deps = constants.cmx types.cmx gcasAutopilot.cmx lowLevelController.cmx \
							      subf16_model.cmx
controlledf16.ml: $(controlledf16Deps:.cmx=.zci)
controlledf16.cmx: $(controlledf16Deps)

run_controlledf16Deps = constants.cmx types.cmx matrix.cmx mlutils.cmx utils.cmx gcasAutopilot.cmx \
											 lowLevelController.cmx subf16_model.cmx \
											 controlledf16.cmx
run_controlledf16.ml run_controlledf16_main.ml: $(run_controlledf16Deps:.cmx=.zci)
run_controlledf16.cmx: $(run_controlledf16Deps)
run_controlledf16.opt: INCLUDES += $(run_controlledf16Deps:.cmx=.cmx)
run_controlledf16.opt: $(run_controlledf16Deps:.cmx=.cmx) run_controlledf16_main.ml

run_subf16_modelDeps = constants.cmx types.cmx matrix.cmx mlutils.cmx utils.cmx \
											 subf16_model.cmx
run_subf16_model.ml run_subf16_model_main.ml: $(run_subf16_modelDeps:.cmx=.zci)
run_subf16_model.cmx: $(run_subf16_modelDeps)
run_subf16_model.opt: INCLUDES += $(run_subf16_modelDeps:.cmx=.cmx)
run_subf16_model.opt: $(run_subf16_modelDeps:.cmx=.cmx) run_subf16_model_main.ml

clean:
	-@rm -rf types.ml
	-@rm -rf lowLevelController.ml
	-@rm -rf gcasAutopilot.ml
	-@rm -rf controlledf16.ml
	-@rm -rf subf16_model.ml
	-@rm -rf run_subf16_model.ml run_subf16_model_main.ml
	-@rm -rf run_controlledf16.ml run_controlledf16_main.ml
	-@rm -rf utils.ml
	-@rm -rf *.annot *.zci *.cm[iox]

cleanall realclean: clean
	-@rm -rf *.byte *.opt *.out

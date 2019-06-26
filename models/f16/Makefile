include ../../config

ZELUC = zeluc
ZLLIB = `zeluc -where`

default: run_controlledf16.byte

%.ml %.zci: %.zls
	$(ZELUC) $<
%.cmo:%.ml

%.byte: ZLEXTRALIBS=$(ZLGTKLIBS)
%.byte: ZELUCFLAGS=-gtk2
%.byte: %.ml
	$(OCAMLC) $(OCAMLFLAGS) -o $@ \
	    -I $(ZLLIB) $(ZLSTDLIBS) $(ZLEXTRALIBS) \
			$(INCLUDES) \
	    $< $(<:.ml=_main.ml)
%.opt: ZLEXTRALIBS=$(ZLGTKLIBS)
%.opt: ZELUCFLAGS=-gtk2
%.opt: %.ml
	$(OCAMLOPT) $(OCAMLOPTFLAGS) -o $@ \
	    -I $(ZLLIB) $(ZLSTDLIBS:.cma=.cmxa) $(ZLEXTRALIBS:.cma=.cmxa) \
			$(INCLUDES) \
	    $< $(<:.ml=_main.ml)

%_main.ml: %.zls
	$(ZELUC) -s main $(ZELUCFLAGS) -o $(@:.ml=) $<

# dependencies

utilsDeps = constants.cmo matrix.cmo mlutils.cmo
utils.ml: $(utilsDeps:.cmo=.zci)
utils.cmo: $(utilsDeps)

subf16_modelDeps = constants.cmo types.cmo mlutils.cmo utils.cmo
subf16_model.ml: $(subf16_modelDeps:.cmo=.zci)
subf16_model.cmo: $(subf16_modelDeps)

lowLevelControllerDeps = constants.cmo types.cmo matrix.cmo mlutils.cmo utils.cmo
lowLevelController.ml: $(lowLevelControllerDeps:.cmo=.zci)
lowLevelController.cmo: $(lowLevelControllerDeps)

gcasAutopilotDeps = constants.cmo mlutils.cmo utils.cmo types.cmo
gcasAutopilot.ml: $(gcasAutopilotDeps:.cmo=.zci)
gcasAutopilot.cmo: $(gcasAutopilotDeps)

controlledf16Deps = constants.cmo types.cmo gcasAutopilot.cmo lowLevelController.cmo \
							      subf16_model.cmo
controlledf16.ml: $(controlledf16Deps:.cmo=.zci)
controlledf16.cmo: $(controlledf16Deps)

run_controlledf16Deps = constants.cmo types.cmo matrix.cmo mlutils.cmo utils.cmo gcasAutopilot.cmo \
											 lowLevelController.cmo subf16_model.cmo \
											 controlledf16.cmo
run_controlledf16.ml run_controlledf16_main.ml: $(run_controlledf16Deps:.cmo=.zci)
run_controlledf16.cmo: $(run_controlledf16Deps)
run_controlledf16.byte: INCLUDES += $(run_controlledf16Deps)
run_controlledf16.byte: $(run_controlledf16Deps) run_controlledf16_main.ml
run_controlledf16.opt: INCLUDES += $(run_controlledf16Deps:.cmo=.cmx)
run_controlledf16.opt: $(run_controlledf16Deps:.cmo=.cmx) run_controlledf16_main.ml

test_controlledf16Deps = constants.cmo types.cmo matrix.cmo mlutils.cmo utils.cmo gcasAutopilot.cmo \
											 lowLevelController.cmo subf16_model.cmo \
											 controlledf16.cmo
test_controlledf16.ml: $(test_controlledf16Deps:.cmo=.zci)
test_controlledf16.ml: ZLEXTRALIBS=zllib.cma
test_controlledf16.ml: ZELUCFLAGS=-I ../../src/S-Taliro
test_controlledf16.cmo: $(test_controlledf16Deps)
test_controlledf16.cmo: INCLUDES += $(test_controlledf16Deps) -I ../../src/S-Taliro staliro_global.cmo
test_controlledf16.cmo: $(test_controlledf16Deps)
test_controlledf16.cmx: INCLUDES += $(test_controlledf16Deps:.cmo=.cmx)
test_controlledf16.cmx: $(test_controlledf16Deps:.cmo=.cmx)

run_subf16_modelDeps = constants.cmo types.cmo matrix.cmo mlutils.cmo utils.cmo \
											 subf16_model.cmo
run_subf16_model.ml run_subf16_model_main.ml: $(run_subf16_modelDeps:.cmo=.zci)
run_subf16_model.cmo: $(run_subf16_modelDeps)
run_subf16_model.byte: INCLUDES += $(run_subf16_modelDeps)
run_subf16_model.byte: $(run_subf16_modelDeps) run_subf16_model_main.ml
run_subf16_model.opt: INCLUDES += $(run_subf16_modelDeps:.cmo=.cmx)
run_subf16_model.opt: $(run_subf16_modelDeps:.cmo=.cmx) run_subf16_model_main.ml

run_sa.byte: run_sa.ml test_controlledf16.cmo
	$(OCAMLC) $(OCAMLFLAGS) -o $@ \
	    -I $(ZLLIB) $(ZLSTDLIBS) $(ZLEXTRALIBS) \
			-I ../../src sim.cmo \
			-I ../../src/sampling sampler.cmo \
			-I ../../src/S-Taliro staliro_global.cmo staliro_types.cmo staliro_utils.cmo SA_Taliro.cmo \
			$(test_controlledf16Deps) test_controlledf16.cmo \
			run_sa.ml

clean:
	-@rm -rf types.ml
	-@rm -rf lowLevelController.ml
	-@rm -rf gcasAutopilot.ml
	-@rm -rf controlledf16.ml
	-@rm -rf subf16_model.ml
	-@rm -rf run_subf16_model.ml run_subf16_model_main.ml
	-@rm -rf run_controlledf16.ml run_controlledf16_main.ml
	-@rm -rf test_controlledf16.ml test_controlledf16_main.ml
	-@rm -rf utils.ml
	-@rm -rf *.annot *.zci *.cm[iox]

cleanall realclean: clean
	-@rm -rf *.byte *.opt *.out

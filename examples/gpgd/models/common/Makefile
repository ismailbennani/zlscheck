include ../../../../config

ZELUCFLAGS += -copy -noreduce
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa discrete_obs_fad.cmx

COMMON_ML = $(shell echo *.ml)
COMMON_MLI = $(shell echo *.mli)
COMMON_ZLS = $(shell echo *.zls)
COMMON_ZLI = $(shell echo *.zli)

all: $(COMMON_ML:.ml=.cmx) $(COMMON_ZLI:.zli=.zci) $(COMMON_ZLS:.zls=.cmx)

interp.cmx common_types.cmx: myOp.cmx
interp.zci: myOp.zci

$(COMMON_ZLS:.zls=.ml): $(COMMON_ZLI:.zli=.zci)

discrete_obs_fad.ml: discrete_obs_fad.zls
	$(ZELUC) $(ZELUCFLAGS) $(@:.ml=.zls)
	sed -i "s/Obj.magic ():MyOp.t/create ():MyOp.t/g" $@

clean cleanall realclean:
	-rm -f $(COMMON_ML:.ml=.cmx) $(COMMON_ML:.ml=.cmi) $(COMMON_ML:.ml=.o)
	-rm -f $(COMMON_ZLI:.zli=.zci)
	-rm -f $(COMMON_ZLS:.zls=.zci) $(COMMON_ZLS:.zls=.ml) $(COMMON_ZLS:.zls=.cmx)

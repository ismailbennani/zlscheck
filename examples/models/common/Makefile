include ../../../config

ZELUCFLAGS += -noreduce -I $(CHECKLIB)
INCLUDES += -I $(CHECKLIB) zlscheck.cmxa

COMMON_ML = $(shell echo *.ml)
COMMON_MLI = $(shell echo *.mli)
COMMON_ZLS = $(shell echo *.zls)
COMMON_ZLI = $(shell echo *.zli)

all: $(COMMON_ML:.ml=.cmx) $(COMMON_ZLI:.zli=.zci) $(COMMON_ZLS:.zls=.cmx)

$(COMMON_ZLS:.zls=.ml): $(COMMON_ZLI:.zli=.zci)

clean cleanall realclean:
	-rm -f $(COMMON_ML:.ml=.cmx) $(COMMON_ML:.ml=.cmi) $(COMMON_ML:.ml=.o)
	-rm -f $(COMMON_ZLI:.zli=.zci)
	-rm -f $(COMMON_ZLS:.zls=.zci) $(COMMON_ZLS:.zls=.ml) $(COMMON_ZLS:.zls=.cmx)

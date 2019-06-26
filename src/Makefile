include ../config

OBJ ?=
ZCI ?=

all: byte

# ----------------
# SAMPLING
# ----------------

OBJ += sampling/sampler.cmo
OBJ += sampling/dumper.cmo

sampling/dumper.cmo: INCLUDES =

sampling/sampler.cmo: INCLUDES += -I sampling dumper.cmo
sampling/sampler.cmo: sampling/dumper.cmo

# ----------------
# S-Taliro
# ----------------

OBJ += S-Taliro/SA_Taliro.cmo S-Taliro/staliro_global.cmo
ZCI += S-Taliro/staliro_global.zci

S-Taliro/SA_Taliro.cmo: INCLUDES += -I S-Taliro staliro_types.cmo staliro_utils.cmo
S-Taliro/SA_Taliro.cmo: S-Taliro/staliro_types.cmo S-Taliro/staliro_utils.cmo

# ----------------
#
# ----------------

OBJ += sim.cmo

# ----------------
# MAIN
# ----------------

byte: $(OBJ) $(ZCI)

show_obj:
	@echo $(OBJ)

clean:
	-@rm -rf *.cm[iox] *.annot
	-@rm -rf sampling/*.cm[iox] sampling/*.annot
	-@rm -rf S-Taliro/*.cm[iox] S-Taliro/*.annot

cleanall realclean: clean

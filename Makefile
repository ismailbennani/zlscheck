include config

all: src lib

src:
	$(MAKE) -C src

# lib

lib:
	rm -rf lib
	mkdir -p lib
	-cp src/*.zci lib
	-cp src/*.cmi lib
	# -cp src/*.cmx lib
	-cp src/*.o lib
	-cp src/*.a lib
	-cp src/*.cma lib
	-cp src/*.cmxa lib

# CLEANING STUFF

clean:
	-@$(MAKE) -C src clean

realclean cleanall:
	-@$(MAKE) -C src cleanall
	-@rm -rf lib

.PHONY: src lib

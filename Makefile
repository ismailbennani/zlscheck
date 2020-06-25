include config

all: src lib

src: ext config
	$(MAKE) -C src

config:
	./configure

ext: zelus fadbadml

zelus:
	cd external/zelus; ./configure
	$(MAKE) -C external/zelus

fadbadml:
	$(MAKE) -C external/fadbadml

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
	-$(MAKE) -C src clean

realclean cleanall:
	-$(MAKE) -C src cleanall
	-$(MAKE) -C examples cleanall
	-$(MAKE) -C external/zelus cleanall
	-$(MAKE) -C external/fadbadml cleanall
	-rm -rf lib config

.PHONY: src lib

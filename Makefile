.PHONY: src models

all: src

config:
	./configure

src:
	$(MAKE) -C src all

models:
	$(MAKE) -C models all

clean:
	$(MAKE) -C models clean
	$(MAKE) -C src clean
	-@rm -rf config.log

cleanall realclean: clean
	$(MAKE) -C models cleanall
	$(MAKE) -C src cleanall
	-@rm -rf lib

distclean: cleanall
	-@rm -rf config META

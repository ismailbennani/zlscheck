
all: src

config:
	./configure

src:
	$(MAKE) -C src all

models:
	$(MAKE) -C models all

clean:
	touch config
	$(MAKE) -C models clean
	$(MAKE) -C src clean
	-@rm -rf config.log

distclean: clean
	-@rm -rf config META

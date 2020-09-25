include config

all: src lib

src: config
	$(MAKE) -C src

config:
	./configure

ext: zelus fadbadml

zelus:
	cd $(ZLDIR); ./configure
	$(MAKE) -C $(ZLDIR)

fadbadml:
	$(MAKE) -C $(FADBADDIR)

lib:
	rm -rf lib
	mkdir -p lib
	-cp src/*.zci lib
	-cp src/*.cmi lib
	-cp src/*.a lib
	-cp src/*.cma lib
	-cp src/*.cmxa lib

docker_build:
	docker build -t zlscheck -f zlscheck.docker .
docker_run:
	docker run -e DISPLAY=$$DISPLAY -v $$XAUTH:/root/.Xauthority -v /tmp/.X11-unix:/tmp/.X11-unix --rm -ti zlscheck bash
zlscheck_docker.tar: docker_build
	docker save zlscheck > zlscheck_docker.tar
docker_load:
	docker load --input zlscheck_docker.tar

# CLEANING STUFF

clean:
	-$(MAKE) -C src clean

clean_ext:
	-$(MAKE) -C $(ZLDIR) cleanall
	-$(MAKE) -C $(FADBADDIR) cleanall

realclean cleanall: clean_ext
	-$(MAKE) -C src cleanall
	-$(MAKE) -C arch cleanall
	-rm -rf lib

.PHONY: src lib

include ../../config

all: test_node_fad.opt

diff_solve.ml: ZELUCFLAGS += -I $(CHECKLIB) -I $(FADBADLIB) -s main -o diff_solve_main
diff_solve.opt: INCLUDES += -I $(CHECKLIB) zlscheck.cma -I $(FADBADLIB) fadbad.cma

test_node_fad.ml: ZELUCFLAGS += -I $(CHECKLIB) -I $(FADBADLIB) -s main -o test_node_fad_main
test_node_fad.opt: INCLUDES += -I $(CHECKLIB) zlscheck.cma -I $(FADBADLIB) fadbad.cma

clean:
	rm -f *.zci *.cm[iox] *.opt *.o
	rm -f diff_solve.ml diff_solve_main.ml

cleanall: clean
	$(MAKE) -C test_hyb_fad cleanall
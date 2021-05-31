# Zlscheck

A random testing tool for Zélus.

`master` has been merged with `rework` and now contains both the discrete and hybrid falsification tool. The important difference here between a discrete and a hybrid model is that the hybrid one uses SundialsML to solve ODEs. The bulk of the work was to connect gradients computed by SundialsML using their sensitivity analysis tools to the gradients propagated with FADBADml. This connection is made by a module called `Nodes_fad` and based on Marc's `Node` module.

# Compile

## On your machine

You will need `ocaml>=4.08.1` and `opam`, please refer to [opam website](https://opam.ocaml.org/doc/Install.html).

Install required libraries:

```
sudo apt-get install -y build-essential sudo m4 libgtk2.0-dev
opam install -y graphics ocamlfind menhir lablgtk sundialsml fadbadml zelus zelus-gtk
```

Additionnal dependencies:

- zelus
- fadbadml

Run `make` then go to `arch/arch20` and run `make` again. You will generate executables `run_bench.opt` and `replay_bench.opt`.

## On a Docker container

A `.tar` Docker container is available under [Packages](https://github.com/ismailbennani/zlscheck/packages) on github, you can either load it by downloading it and saving it as `zlscheck/zlscheck_docker.tar` then run

```
make docker_load
```

or build it yourself from `zlscheck.docker` by running

```
make docker_build
```

Once the image is built or loaded, you can run `bash` inside it by running

```
make docker_run
```

This docker image has been tested on a fresh install of Ubuntu 20.04.

# Usage

This archive contains source code for:

- in `/home/zelus`: source code for `zeluc` compiler and Zélus runtime libraries
- in `/home/fadbadml`: source code for `FADBADml`, a tool for automatic differentiation in OCaml
- in `/home/zlscheck`: source code for `zlscheck` tool
- in `/home/zlscheck/arch/arch20`: code for ARCH2020, including the models translated to Zélus in `models/` and several matlab script to validate the counter-examples found by `zlscheck` under `matlab/`.

The main program is `run_bench.opt` under `/home/zlscheck/arch/arch20`, it takes a list of benchmarks to run as mandatory argument and a bunch of optional arguments, please run `./run_bench.opt --help` to learn more.

Note: the paths given here are the ones inside the Docker container. If you do not use Docker you can find `zelus/` and `fadbadml/` under `zlscheck/external/`.

Usage examples:

- Run instance 1 of model AT with property 1 with 50 repetitions and 300 runs per repetition:
  `./run_bench -r 50 -n 300 AT1_inst1`
- Run instance 1 of model AT with property 1 with 50 repetitions and 300 runs per repetition using Uniform Random as an optimization algorithm:
  `./run_bench -r 50 -n 300 AT1_inst1_ur`
- Run both benchmarks in one command:
  `./run_bench -r 50 -n 300 AT1_inst1 AT1_inst1_ur`
- Run instance 1 of model AT for all properties:
  `./run_bench -r 50 -n 300 AT_inst1`
- Run all benchmarks (except WT4 because it takes too long) using 8 processes:
  `./run_bench -r 50 -n 300 -j 8 arch20`

The falsifying runs are dumped by default in `benchmarks/` as csv files, the dump folder can be changed with option `-d`.
There is currently no way to run matlab inside this docker, to validate the results you will need to copy those dumps into your host computer along with folders `matlab/` and `shared/` then run matlab script `validate_all.m` located in subfolders of `benchmarks/` or scripts `validate.m` in folder `benchmarks/[modelname]`. The validation scripts use S-TALIRO dp-taliro function, the S-TALIRO and matlab_bgl toolboxes should be in the MATLAB path.

Note: There are only two benchmarks that have different parameters for instance 1 and instance 2 in my tests, namely AT and NN. For the other benchmarks, there is only one set of parameter used for both instances. Please refer to `run_bench` help message to have an exhaustive list of available benchmarks.

`replay_bench.opt` plots a particular run from a csv dump. Its first argument is the name of the model to plot (refer to `./replay_bench.opt --help`) and the second is the path to the dump file.

Usage example:

- `./replay_bench.opt at benchmarks/at_inst1/dump_autotrans_AT1_inst1_offline_GD_Classic/dump000000.csv`

`read_results.opt` gathers the results of an execution of zlscheck and outputs a latex table (or pdf). Those results are stored by zlscheck in files named `info` along with the csv dumps. This program reads all such files `info` in the subtree of its argument.

Usage example:

- `./read_results.opt benchmarks > results.tex`
- `./read_results.opt --short benchmarks > results.tex`
- `./read_results.opt --pdf benchmarks > results.pdf`

You can find pre-generated benchmarks results at https://github.com/ismailbennani/zlscheck_arch20_counterexamples.

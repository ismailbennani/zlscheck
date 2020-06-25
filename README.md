# Zlscheck
A random testing tool for Zélus

# Compile
## On your machine

You will need `ocaml>=4.08` and `opam`, please refer to [opam website](https://opam.ocaml.org/doc/Install.html).

Install required libraries:

```
sudo apt-get install -y build-essential sudo m4 libgtk2.0-dev libsundials-dev
opam install -y graphics ocamlfind menhir sundialsml lablgtk ocamlfind
```

Additionnal dependencies:
- zelus
- fadbadml

Both libraries can be found under `external/` and can be compiled by running `make ext`.

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

# Usage

This archive contains source code for:
- in `/home/zelus`: source code for `zeluc` compiler and Zélus runtime libraries
- in `/home/fadbadml`: source code for `FADBADml`, a tool for automatic differentiation in OCaml
- in `/home/zlscheck`: source code for `zlscheck` tool
- in `/home/zlscheck/arch/arch20`: code for ARCH2020, including the models translated to Zélus in `models/` and several matlab script to validate the counter-examples found by `zlscheck` under `matlab/`.

The main program is `run_bench.opt` under `/home/zlscheck/arch/arch20`, it takes a list of benchmarks to run as mandatory argument and a bunch of optional arguments, please run `./run_bench.opt --help` to learn more.

Note: the paths given here are the ones in Docker. If you do not use Docker you can find `zelus/` and `fadbadml/` under `zlscheck/external/`, and `arch20/` in `zlscheck/examples/`.

Usage examples:
- Run instance 1 of model AT with property 1 with 50 repetitions and 300 runs per repetition:
    `./run_bench -r 50 -n 300 AT1_inst1`
- Run instance 1 of model AT with property 1 with 50 repetitions and 300 runs per repetition using Uniform Random as an optimization algorithm:
    `./run_bench -r 50 -n 300 AT1_inst1_ur`
- Run both benchmarks in one command:
    `./run_bench -r 50 -n 300 AT1_inst1 AT1_inst1_ur`
- Run instance 1 of model AT for all properties:
    `./run_bench -r 50 -n 300 AT_inst1`

The falsifying runs are dumped by default in `benchmarks/` as csv files, the dump folder can be changed with option `-d`. There is currently no way to run matlab inside this docker, to validate the results you will need to copy those dumps into your host computer along with folders `matlab/` and `shared/` then run matlab script `validate_all.m` located in subfolders of `benchmarks/` or scripts `validate.m` in folder `benchmarks/[modelname]`.

Note: if you encounter a Gtk initialization error, please run `xhost +` on your host computer.

Note: There are only two benchmarks that have different parameters for instance 1 and instance 2 in my tests, namely AT and NN. For the other benchmarks, there is only one set of parameter used for both instances. Please refer to `run_bench` help message to have an exhaustive list of available benchmarks.

`replay_bench.opt` enables you to plot a particular run from its csv dump. Its first argument is the name of the model to plot (refer to `./replay_bench.opt --help`) and the second is the path to the dump file.

Usage example:
- `./replay_bench.opt at benchmarks/at_inst1/dump_autotrans_AT1_inst1_offline_GD_Classic/dump000000.csv`

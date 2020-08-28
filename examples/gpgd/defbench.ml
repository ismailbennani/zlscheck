module Autotrans =
struct
  let tstep = 0.01
  let bounds = [|0.,100.; 0.,350.|]

  module Phi1 =
  struct
    let name = "AT1"
    let max_t = 20.
    let max_n = truncate (max_t /. tstep)
    let node = At_bench.autotrans_at1 tstep
    let set_optim_params () =
      Optim_globals.params.bounds <- bounds;
      Optim_globals.params.meth.gd.alpha <- 100000.
  end

  module Phi2 =
  struct
    let name = "AT2"
    let max_t = 10.
    let max_n = truncate (max_t /. tstep)
    let node = At_bench.autotrans_at2 tstep
    let set_optim_params () =
      Optim_globals.params.bounds <- bounds;
      Optim_globals.params.meth.gd.alpha <- 10000.
  end

  module Phi51 =
  struct
    let name = "AT51"
    let max_t = 32.5
    let max_n = truncate (max_t /. tstep)
    let node = At_bench.autotrans_at51 tstep
    let set_optim_params () =
      Optim_globals.params.bounds <- bounds;
      Optim_globals.params.meth.gd.alpha <- 1.
  end

  module Phi52 =
  struct
    let name = "AT52"
    let max_t = 32.5
    let max_n = truncate (max_t /. tstep)
    let node = At_bench.autotrans_at52 tstep
    let set_optim_params () =
      Optim_globals.params.bounds <- bounds;
      Optim_globals.params.meth.gd.alpha <- 1.
  end

  module Phi53 =
  struct
    let name = "AT53"
    let max_t = 32.5
    let max_n = truncate (max_t /. tstep)
    let node = At_bench.autotrans_at53 tstep
    let set_optim_params () =
      Optim_globals.params.bounds <- bounds;
      Optim_globals.params.meth.gd.alpha <- 1.
  end

  module Phi54 =
    struct
    let name = "AT54"
    let max_t = 32.5
    let max_n = truncate (max_t /. tstep)
    let node = At_bench.autotrans_at54 tstep
    let set_optim_params () =
      Optim_globals.params.bounds <- bounds;
      Optim_globals.params.meth.gd.alpha <- 1.
  end

  module Phi6a =
  struct
    let name = "AT6a"
    let max_t = 30.
    let max_n = truncate (max_t /. tstep)
    let node = At_bench.autotrans_at6a tstep
    let set_optim_params () =
      Optim_globals.params.bounds <- bounds;
      Optim_globals.params.meth.gd.alpha <- 100000.;
      Optim_globals.params.meth.gpo.eps <- 1e-6
  end

  module Phi6b =
  struct
    let name = "AT6b"
    let max_t = 30.
    let max_n = truncate (max_t /. tstep)
    let node = At_bench.autotrans_at6b tstep
    let set_optim_params () =
      Optim_globals.params.bounds <- bounds;
      Optim_globals.params.meth.gd.alpha <- 100.
    end

  module Phi6c =
  struct
    let name = "AT6c"
    let max_t = 30.
    let max_n = truncate (max_t /. tstep)
    let node = At_bench.autotrans_at6c tstep
    let set_optim_params () =
      Optim_globals.params.bounds <- bounds;
      Optim_globals.params.meth.gd.alpha <- 1000.
  end
end

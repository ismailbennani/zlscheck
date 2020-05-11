open Optim_types

let params = {
  max_n_runs = 500;
  mode = Optim_types.Falsify;
  bounds = [||];
  init_sample = None;
  vverbose = false;
  verbose = false;
  meth = {
    ur = ();
    particle = {
      n = 10;
    };
    sa = {
      dispAdap = 10.;
      betaXAdap = 50.;
      minDisp = 0.01;
      maxDisp = 0.99;
      acRatioMin = 0.45;
      acRatioMax = 0.55;
      dispStart = 0.75;
      betaXStart = -15.;
    };
    gd = {
      alpha = 0.5;
      beta1 = 0.9;
      beta2 = 0.999;
      do_restart = false
    }
  }
}

let set_params p =
  params.max_n_runs <- p.max_n_runs;
  params.mode <- p.mode;
  params.bounds <- p.bounds;
  params.init_sample <- p.init_sample;
  params.verbose <- p.verbose;
  params.vverbose <- p.vverbose;
  params.meth.particle.n <- p.meth.particle.n;
  params.meth.sa.dispAdap <- p.meth.sa.dispAdap;
  params.meth.sa.betaXAdap <- p.meth.sa.betaXAdap;
  params.meth.sa.minDisp <- p.meth.sa.minDisp;
  params.meth.sa.maxDisp <- p.meth.sa.maxDisp;
  params.meth.sa.acRatioMin <- p.meth.sa.acRatioMin;
  params.meth.sa.acRatioMax <- p.meth.sa.acRatioMax;
  params.meth.sa.dispStart <- p.meth.sa.dispStart;
  params.meth.sa.betaXStart <- p.meth.sa.betaXStart;
  params.meth.gd.alpha <- p.meth.gd.alpha;
  params.meth.gd.beta1 <- p.meth.gd.beta1;
  params.meth.gd.beta2 <- p.meth.gd.beta2;
  params.meth.gd.do_restart <- p.meth.gd.do_restart;

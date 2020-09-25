open Optim_types

let params = {
  max_n_runs = 500;
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
      do_restart = false;
      restart_fn = fun _ -> ();
    };
    gpo = {
      nb_init_samples = 1;
      a = 1.;
      b = 1.;
      alpha = 1.;
      beta = 1.;
      eps = 0.0001;
      gd_miniter = 10;
      gd_maxiter = 100;
    };
  }
}

let set_params p =
  params.max_n_runs <- p.max_n_runs;
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
  params.meth.gpo.nb_init_samples <- p.meth.gpo.nb_init_samples;
  params.meth.gpo.a <- p.meth.gpo.a;
  params.meth.gpo.b <- p.meth.gpo.b;
  params.meth.gpo.alpha <- p.meth.gpo.alpha;
  params.meth.gpo.beta <- p.meth.gpo.beta;
  params.meth.gpo.eps <- p.meth.gpo.eps;
  params.meth.gpo.gd_miniter <- p.meth.gpo.gd_miniter;
  params.meth.gpo.gd_maxiter <- p.meth.gpo.gd_maxiter;

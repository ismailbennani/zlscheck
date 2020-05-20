%% Interface
mdl = 'steamcondense_RNN_22_BR';
B = BreachSimulinkSystem(mdl);
B.SetTime(0:.01:35);

%% Input Configuration
B.SetInputGen('UniStep12');
p = B.GetInputParamList();
B.SetParamRanges(p, [3.99 4.01]);

%% 20 quasi random simulations
B1 = B.copy();
B1.QuasiRandomSample(20);
B1.Sim();
B1.PlotSignals();

%% Requirements
STL_ReadFile('requirements_breach.stl');
R = BreachRequirement(r);
R1 = R.copy();
[v V ]= R1.Eval(B1);

%% Falsification Problem - GMN 
pb1 = FalsificationProblem(B, R);
pb1.max_obj_eval = 10000;
pb1.solver_options.nb_max_corners = 4096;
pb1.solver_options.nb_new_trials= 5000;
pb1.SetupDiskCaching();
%pb1.SetupParallel();
pb1.solve();
Rlog1 = pb1.GetLog();
return
%% Falsification Problem - CMA-ES
pb2 = FalsificationProblem(B, R);
pb2.max_obj_eval = 300;
pb2.setup_cmaes();
pb2.solve();
Rlog2 = pb2.GetLog();


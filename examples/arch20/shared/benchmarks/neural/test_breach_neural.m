%% Interface
init_neural;
mdl = 'narmamaglev_v1';
B3cp = BreachSimulinkSystem(mdl);

%% Input Configuration
B3cp.SetInputGen('UniStep3');
InputParams = B3cp.GetInputParamList();
B3cp.SetParamRanges(InputParams, [1 3]);

%% 20 QuasiRandom Simulations 
B1 = B3cp.copy();
B1.QuasiRandomSample(20);
B1.Sim();
figure;
B1.PlotSignals();

%% Requirements
STL_ReadFile('requirements_breach.stl');
Rbeta3 = BreachRequirement(NNreq);

%% Looking at quasi random traces
R1 = Rbeta3.copy();
R1.Eval(B1)
BreachSamplesPlot(R1);

%% Falsification Problem 
pb1 = FalsificationProblem(B3cp,Rbeta3);
pb1.max_obj_eval= 300;
pb1.solve();

%% Log
Rlog1 = pb1.GetLog();
F1 = BreachSamplesPlot(Rlog1);

%% Falsification Problem, harder (beta= 0.04)
Rbeta4 = Rbeta3.copy();
Rbeta4.SetParam('bet', 0.04);


%% Falsification Problem - CMAES
pb2 = FalsificationProblem(B3cp,Rbeta4);
pb2.max_obj_eval= 300;
pb2.solve();
Rlog2 = pb2.GetLog();
F2 = BreachSamplesPlot(Rlog2);

%% Falsification Problem - CMAES
pb3 = FalsificationProblem(B3cp,Rbeta4);
pb3.max_obj_eval= 300;
pb3.setup_cmaes();
pb3.solve();
Rlog3 = pb3.GetLog();
F3 = BreachSamplesPlot(Rlog3);


%% Input parameterization with max control points
B12cp = B3cp.copy();
B12cp.SetInputGen('UniStep12');
InputParams = B12cp.GetInputParamList();
B12cp.SetParamRanges(InputParams, [1 3]);

%% 12 cps, beta = 0.03 
pb4 = FalsificationProblem(B12cp,Rbeta3);
pb4.max_obj_eval= 300;
pb4.solve();
Rlog4= pb4.GetLog();
F4 = BreachSamplesPlot(Rlog4);

%% 12cps, beta = 0.04, GNM
pb5 = FalsificationProblem(B12cp,Rbeta4);
pb5.max_obj_eval= 300;
pb5.solve();
Rlog5= pb5.GetLog();
F5 = BreachSamplesPlot(Rlog5);

%% 12cps, beta = 0.04, CMA-ES
pb6 = FalsificationProblem(B12cp,Rbeta4);
pb6.max_obj_eval= 300;
pb6.setup_cmaes();
pb6.solve();
Rlog6= pb6.GetLog();
F6 = BreachSamplesPlot(Rlog6);








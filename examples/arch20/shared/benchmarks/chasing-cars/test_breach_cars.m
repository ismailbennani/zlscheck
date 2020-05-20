clc;
clear;

%% 
B0 = BreachSimulinkSystem('cars');

%% Input Specification
B0.SetInputGen('UniStep4');
Inputs = B0.GetInputParamList();
B0.SetParamRanges(Inputs, [0 1.]);

%% 20 quasi random simulations
B1 = B0.copy();
B1.QuasiRandomSample(20);
B1.Sim();
figure;
B1.PlotSignals();

%% Requirements
STL_ReadFile('requirements_breach.stl');
R = BreachRequirement({fml1,fml2,fml3,fml4,fml5});
R1 = R.copy();
R1.Eval(B1);
F1 = BreachSamplesPlot(R1);

%% Falsification 
% Formula 4 seems hardest to falsify
R4= BreachRequirement(fml4);
pb = FalsificationProblem(B0, R4);
pb.max_obj_eval = 300; 
pb.setup_cmaes();
pb.solve();

% plot log
Rlog = pb.GetLog();
BreachSamplesPlot(Rlog);

%% Instance 2: cp every 5s
B2 = B0.copy();
B2.SetInputGen('UniStep20');
Inputs2 = B2.GetInputParamList();
B2.SetParamRanges(Inputs2, [0 1.]);

%% Falsification 
pb2 = FalsificationProblem(B2, R4);
pb2.max_obj_eval = 300; 
pb2.setup_cmaes();
pb2.solve();

% Plot log
Rlog2 = pb2.GetLog();
BreachSamplesPlot(Rlog2);





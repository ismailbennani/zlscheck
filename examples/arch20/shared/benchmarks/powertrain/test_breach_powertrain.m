%% Interface
clc;
clear all;
init_powertrain;
B0 = BreachSimulinkSystem('AbstractFuelControl_M1');

%% Input configuration
sig_gen = fixed_cp_signal_gen({'throttle', 'engine'}, [10 1], 'previous'); 
B0.SetInputGen(sig_gen);
for i = 0:9
    B0.SetParamRanges(['throttle_u' num2str(i)], [0 61.1]);
end
B0.SetParamRanges('engine_u0', [900 1100]);

%% Requirement 
STL_ReadFile('requirements_breach.stl');
R0 = BreachRequirement(req);

%% Falsification Problem
pb0 =  FalsificationProblem(B0, R0);
pb0.max_obj_eval = 300;
pb0.solve();

%% Log
Rlog = pb0.GetLog();
BreachSamplesPlot(Rlog);


%% Falsification Problem, harder
R1 = R0.copy();
R1.SetParam('mu_tol', 0.009);
pb1 =  FalsificationProblem(B0, R1);
pb1.max_obj_eval = 300;
pb1.solve();

%%
Rlog1 = pb1.GetLog();
BreachSamplesPlot(Rlog1);
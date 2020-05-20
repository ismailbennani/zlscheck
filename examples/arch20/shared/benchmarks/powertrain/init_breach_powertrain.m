%% Interface
clc;
clear all;
init_powertrain;
addpath ../../../breach
B0 = BreachSimulinkSystem('AbstractFuelControl_M1');

%% Input configuration
sig_gen = fixed_cp_signal_gen({'throttle', 'engine'}, [10 1], 'previous'); 
B2 = B0.copy();
B2.SetInputGen(sig_gen);
for i = 0:9
    B2.SetParamRanges(['throttle_u' num2str(i)], [0 61.2]);
end
B2.SetParamRanges('engine_u0', [900 1100]);

B33 = B0.copy();
B33.SetInputGen(sig_gen);
for i = 0:9
    B33.SetParamRanges(['throttle_u' num2str(i)], [61.2 81.2]);
end
B33.SetParamRanges('engine_u0', [900 1100]);



%% Requirement 
STL_ReadFile('requirements_breach.stl');
R27 = BreachRequirement(AFC27);
R29 = BreachRequirement(AFC29);



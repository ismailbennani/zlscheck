addpath ../../../breach

%% Interface
mdl = 'steamcondense_RNN_22_BR';
B = BreachSimulinkSystem(mdl);
B.SetTime(0:.01:35);

%% Input Configuration
B.SetInputGen('UniStep20');
p = B.GetInputParamList();
B.SetParamRanges(p, [3.99 4.01]);

%% Requirements
STL_ReadFile('requirements_breach.stl');
R = BreachRequirement(r);



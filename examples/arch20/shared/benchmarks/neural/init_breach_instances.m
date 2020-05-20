
addpath ../../../breach
%% Interface
init_neural;
mdl = 'narmamaglev_v1';
B1 = BreachSimulinkSystem(mdl);

%% Input Configuration
B1.SetInputGen('UniStep3');
InputParams = B1.GetInputParamList();
B1.SetParamRanges(InputParams, [1 3]);

%% Input parameterization with max control points
B2 = B1.copy();
B2.SetInputGen('UniStep12');
InputParams = B2.GetInputParamList();
B2.SetParamRanges(InputParams, [1 3]);

%% Requirements
STL_ReadFile('requirements_breach.stl');
Rbeta3 = BreachRequirement(NNreq);









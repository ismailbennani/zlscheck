clear all
close all
clc

addpath ../../../breach
InitBreach
%% Create interface with wind data
init_SimpleWindTurbine;
IGwind = BreachSignalGen(wind_signal_gen());
time= 0:0.01:630;
IGwind.Sim(); % load one default wind signal

%% Fixed control point wind generator 
IGcp_wind = BreachSignalGen(wind_cp_signal_gen());
mdl = 'SimpleWindTurbine';
B0 = BreachSimulinkSystem(mdl);
B0.InitFn ='init_SimpleWindTurbine';
B0.SetInputGen(IGcp_wind);
B0.InputGenerator.SetDomain('v0', [8 16]);
Inputs = B0.GetInputParamList();
B0.SetParamRanges(Inputs, [8. 16.]);

%%
B = B0.copy();
B.CornerSample(4);
B.SimInputsOnly = true;
B.Sim();


%% Requirements
STL_ReadFile('requirements_breach.stl');
R = BreachRequirement({r1,r2,r3,r4});
Rs = [BreachRequirement(r1), BreachRequirement(r2), BreachRequirement(r3), BreachRequirement(r4)];


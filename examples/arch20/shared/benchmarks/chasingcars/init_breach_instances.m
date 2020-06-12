clc;
clear;

addpath ../../../breach
InitBreach;
%% 
B0 = BreachSimulinkSystem('cars');

%% Input Specification
B1 = B0.copy();
B1.SetInputGen('UniStep4');
Inputs = B0.GetInputParamList();
B1.SetParamRanges(Inputs, [0 1.]);

%% Requirements
STL_ReadFile('requirements_breach.stl');
R1 = BreachRequirement(fml1);
R2 = BreachRequirement(fml2);
R3 = BreachRequirement(fml3);
R4 = BreachRequirement(fml4);
R5 = BreachRequirement(fml5);
Rs = [R1, R2, R3, R4, R5 ];

%% Instance 2: cp every 5s
B2 = B0.copy();
B2.SetInputGen('UniStep20');
Inputs2 = B2.GetInputParamList();
B2.SetParamRanges(Inputs2, [0 1.]);


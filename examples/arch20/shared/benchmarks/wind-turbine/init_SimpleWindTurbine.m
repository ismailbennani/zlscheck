%% init_SimpleWindTurbine
% (C) 2019 Decyphir SAS (C) 2015 General Electic Global Research - all rights reserved

%% ========================================================================
%clear all
%close all
%clc

SimplifiedTurbine_Config;

% add some paths
addpath('tools/')
addpath('wind/')
addpath(config.wafo_path)

%load wind files
load('ClassA.mat')
load('ClassA_config.mat')
load('aeromaps3.mat');

% remove all unnecessary fields (otherwise Simulink will throw an error)
cT_modelrm = rmfield(cT_model,{'VarNames'});%,'RMSE','ParameterVar','ParameterStd','R2','AdjustedR2'});
cP_modelrm = rmfield(cP_model,{'VarNames'});%,'RMSE','ParameterVar','ParameterStd','R2','AdjustedR2'});

% initialize WAFO
initwafo

Parameter.InitialConditions = load('InitialConditions');
Parameter.Time.TMax                 = 630;            % [s]       duration of simulation
Parameter.Time.dt                   = 0.01;           % [s]       time step of simulation
Parameter.Time.cut_in               = 30;


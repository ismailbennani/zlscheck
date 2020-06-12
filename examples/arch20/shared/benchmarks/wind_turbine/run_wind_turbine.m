function [tout, yout] = run_wind_turbine(u, T)    
    %% SimplifiedTurbine_ParameterFile.m
    % Main file to run SimplifiedWTModel.slx 
    % (C) 2015 General Electic Global Research - all rights reserved

    %% ========================================================================
    SimplifiedTurbine_Config;

    % add some paths
    addpath('tools/')
    addpath('wind/')
    addpath(config.wafo_path)

    %load wind files
    load('ClassA.mat')
    load('ClassA_config.mat')

    load('aeromaps3.mat');
    Parameter.InitialConditions = load('InitialConditions');
    % remove all unnecessary fields (otherwise Simulink will throw an error)
    cT_modelrm = rmfield(cT_model,{'VarNames'});%,'RMSE','ParameterVar','ParameterStd','R2','AdjustedR2'});
    cP_modelrm = rmfield(cP_model,{'VarNames'});%,'RMSE','ParameterVar','ParameterStd','R2','AdjustedR2'});

    % initialize WAFO
    initwafo 

    %% single run or all wind cases
    Parameter.TMax                      = T;
    % Time
    Parameter.Time.TMax                 = 630;              % [s]       duration of simulation
    Parameter.Time.dt                   = 0.01;           % [s]       time step of simulation
    Parameter.Time.cut_in               = 30;
    Parameter.Time.cut_out              = Parameter.Time.TMax;
    Parameter.v0_0 = u(1,2);

    Parameter = SimplifiedTurbine_ParamterFile(Parameter);
    
    ts = u(:,1);
    us = u(:,2);
    
    tin = 0:0.01:T;
    xin = interp1(ts, us, tin, 'previous');    
    u = [tin' xin'];
    
    assignin('base','u',u);
    assignin('base','T',T);
    assignin('base','Parameter',Parameter);
    assignin('base','cP_modelrm',cP_modelrm);
    assignin('base','cT_modelrm',cT_modelrm);
    
    result = sim('SimpleWindTurbine', ...
                 'StopTime', 'T', ...
                 'LoadExternalInput', 'on', 'ExternalInput', 'u', ...
                 'SaveTime', 'on', 'TimeSaveName', 'tout', ...
                 'SaveOutput', 'on', 'OutputSaveName', 'yout', ...
                 'SaveFormat', 'Array');
    
    tout = result.tout;
    yout = result.yout;
end

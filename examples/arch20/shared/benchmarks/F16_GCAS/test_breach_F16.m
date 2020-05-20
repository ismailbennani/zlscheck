%% Run Breach with cmaes solver on F16 benchmark

%% F16 setup 
close all; clear; clc;
addpath(genpath('AeroBenchVV-master'));
warning('off', 'f16:no_analysis'); 

%% Breach interface setup
sg = f16_signal_gen();
B = BreachSignalGen(sg);
B.SetTime(0:.01:15);
B.SetParamRanges( {'phig', 'thetag', 'psig'}, [ pi/4-pi/20 pi/4+pi/30;...
    -0.8*pi/2, -pi/2*0.8+pi/20; ...
    -pi/4-pi/8 -pi/4+pi/8]);

%% Breach requirement setup
STL_ReadFile('requirements_breach.stl');
R = BreachRequirement(phi);

%% Falsification Problem
Pb = FalsificationProblem(B,R);
Pb.max_obj_eval = 300;
Pb.setup_cmaes();
Pb.solve();

%% Log
Rlog = Pb.GetLog();
F = BreachSamplesPlot(Rlog);
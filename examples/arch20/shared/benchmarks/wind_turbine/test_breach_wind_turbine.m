clear all
close all
clc

%% Create interface with wind data
init_SimpleWindTurbine;
IGwind = BreachSignalGen(wind_signal_gen());
time= 0:0.01:630;

%% Plots all winds 
IGall_winds = IGwind.copy();
IGall_winds.SampleDomain({'iBin', 'iRandSeed'}, 'all');
IGall_winds.Sim(time);
figure;
IGall_winds.PlotSignals();

%% Checking wind data that actually satisfy input requirement
input_req = STL_Formula('input_req','alw (v0[t] > 8 and v0[t]<16)');
idx = find(IGall_winds.CheckSpec(input_req)>0) % corresponds to bin 5
    
%% Requirements
STL_ReadFile('requirements_breach.stl');
R = BreachRequirement({r1,r2,r3,r4});

%% Tests wind turbine with wind data
mdl = 'SimpleWindTurbine';
B = BreachSimulinkSystem(mdl);
B.InitFn ='init_SimpleWindTurbine';
B.SetInputGen(IGwind);
B.SetParam('iBin', 5);

%% Single run from original benchmark
BSingleRun = B.copy();
BSingleRun.Sim(time);

%%
figure;
BSingleRun.PlotSignals();


%% All runs
BAllRuns = B.copy();
BAllRuns.SetupParallel();
BAllRuns.SampleDomain({'iBin', 'iRandSeed'}, 'all');
BAllRuns.Sim(time);

Rwinds = R.copy();
Rwinds.Eval(BAllRuns);

%%
BreachSamplesPlot(Rwinds);

%% Test with 20 Randomly generated wind signals
Br = BreachSimulinkSystem(mdl);
IGrand_wind = wind_rand_signal_gen();
Br.SetInputGen(IGrand_wind);

%% 
Br20 = Br.copy();
Br20.SetParam('v0_seed', 1:20);
Br20.SetupParallel();
Br20.Sim(time);

%%
R20 = R.copy();
R20.Eval(Br20);
BreachSamplesPlot(R20);

%% Full 300 random runs 

%% 
Br300 = Br.copy();
Br300.SetParam('v0_seed', 1:300);
Br300.SetupParallel();
Br300.Sim(time);

%%
R300 = R.copy();
R300.Eval(Br300);
BreachSamplesPlot(R300);


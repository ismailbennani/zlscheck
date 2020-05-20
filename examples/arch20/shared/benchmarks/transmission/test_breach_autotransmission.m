%% Interface
%clc;
%clear all;
init_transmission;
B0 = BreachSimulinkSystem('Autotrans_shift');
BO.InitFn = 'init_transmission';

%% Input configuration 1
sig_gen = var_cp_signal_gen({'throttle', 'brake'}, [3 2], 'previous'); 
B1 = B0.copy(); 
B1.SetInputGen(sig_gen);
for i = 0:2
    B1.SetParamRanges(['throttle_u' num2str(i)], [0 100]);
end
B1.SetParamRanges({'throttle_dt0','throttle_dt1', 'brake_dt0' }, [0 25]);
B1.SetParamRanges('brake_u0', [0 325]);
B1.SetParamRanges('brake_u1', [0 325]);

%% Input configuration 2
B2 = B0.copy(); 
B2.SetInputGen('UniStep20');
pu = B2.GetInputParamList();
pu_throttle = pu(~cellfun(@isempty, strfind(pu, 'throttle')));
pu_brake = pu(~cellfun(@isempty, strfind(pu, 'brake')));
B2.SetParamRanges(pu_brake, [0 325]);
B2.SetParamRanges(pu_throttle, [0 100]);


%% Requirement 
STL_ReadFile('requirements_breach.stl');
RAT1 = BreachRequirement(AT1);
RAT2 = BreachRequirement(AT2);
RAT51 = BreachRequirement(AT51);
RAT52 = BreachRequirement(AT52);
RAT53= BreachRequirement(AT53);
RAT54 = BreachRequirement(AT54);
RAT6a = BreachRequirement(AT6a);
RAT6b = BreachRequirement(AT6b);
RAT6c = BreachRequirement(AT6c);
Rall = BreachRequirement({AT1,AT2,AT51,AT52,AT53,AT54,AT6a,AT6b,AT6c});

%% Quasi random Instance 1
B1qr = B1.copy();
B1qr.QuasiRandomSample(300);
B1qr.SetupParallel(); 
R1qr = Rall.copy();
R1qr.Eval(B1qr);
BreachSamplesPlot(R1qr);

%% Quasi random Instance 2
B2qr = B2.copy();
B2qr.QuasiRandomSample(300);
B2qr.SetupParallel(); 
R2qr = Rall.copy();
R2qr.Eval(B2qr);
BreachSamplesPlot(R2qr);

%%  Corners Instance 1
B1co = B1.copy();
B1co.CornerSample(300);
B1co.SetupParallel(); 
R1co = Rall.copy();
R1co.Eval(B1co);
BreachSamplesPlot(R1co);

%%  Corners Instance 2
B2co = B2.copy();
B2co.CornerSample(300);
B2co.SetupParallel(); 
R2co = Rall.copy();
R2co.Eval(B2co);
BreachSamplesPlot(R2co);



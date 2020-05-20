%% Interface
clc;
clear all;
init_transmission;
B0 = BreachSimulinkSystem('Autotrans_shift');
BO.InitFn = 'init_transmission';

addpath ../../../breach
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

Rs = [RAT1,RAT2,RAT51,RAT52,RAT53,RAT54,RAT6a,RAT6b,RAT6c];
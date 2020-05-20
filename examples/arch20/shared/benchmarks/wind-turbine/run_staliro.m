% (C) 2019 National Institute of Advanced Industrial Science and Technology
% (AIST)
% (C) 2015 General Electic Global Research - all rights reserved

%% ========================================================================
clear all
close all
%clc

% Configurations
%%%%%%%%%%%%%%%%
global workers_num logDir;
workers_num = 1;
staliro_dir = '~/Factory/s-taliro_public/trunk/';
logDir = 'log/';

maxIter = 1;
maxEpisodes = 200;

config_tmpl = struct('maxIter', maxIter,...
                'maxEpisodes', maxEpisodes);

% Initialization
%%%%%%%%%%%%%%%%
if exist('dp_taliro.m', 'file') == 0
    addpath(staliro_dir);
    cwd = pwd;
    cd(staliro_dir);
    setup_staliro;
    cd(cwd);
end
if ~ 7 == exist(logDir, 'dir')
    mkdir(logDir);
end


% add some paths
addpath('tools')
addpath('wind')
SimplifiedTurbine_Config;
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

iBin = find(URefVector==Parameter.URef);
iRandSeed = 1;

config.iBin                         = iBin;
config.iRandSeed                    = iRandSeed;
Parameter.v0                        = v0_cell{iBin,iRandSeed};
Parameter.v0.signals.values         = Parameter.v0.signals.values';
Parameter.TMax                      = v0_cell{iBin,iRandSeed}.time(end);
config.WindFieldName                = FileNames{iBin,iRandSeed};
% Time
Parameter.Time.TMax                 = 630;              % [s]       duration of simulation
Parameter.Time.dt                   = 0.01;           % [s]       time step of simulation
Parameter.Time.cut_in               = 30;
Parameter.Time.cut_out              = Parameter.Time.TMax;
Parameter.v0_0 = Parameter.v0.signals.values(1);

Parameter = SimplifiedTurbine_ParamterFile(Parameter);

% Formulas
%%%%%%%%%%%%%%%

tmpl = struct(config_tmpl);
tmpl.input_range = [8.0 16.0];
tmpl.output_range = [0.0 13.0; 1.0 3.0; 2.50*10^4 5.0*10^4; 1000.0 1300.0; 10.0 13.0;0.0 13.0];
tmpl.init_opts = {};
tmpl.interpolation = {'linear'};
tmpl.agentName = '/RL agent';
tmpl.stopTime = 630;
tmpl.init_opts = {{'Parameter', Parameter}, {'cT_modelrm', cT_modelrm},...
    {'cP_modelrm', cP_modelrm}};

% Formula 1, mnimum pitch angle
fml1 = struct(tmpl);
fml1.expName = 'fml1';
fml1.targetFormula = '[]_[30, 630](p2 -> p1)';
fml1.monitoringFormula = 'p2 -> p1';

fml1.preds(1).str = 'p1';
fml1.preds(1).A = [0 0 0 0 0 -1];
fml1.preds(1).b = -0.001;
fml1.preds(2).str = 'p2';
fml1.preds(2).A = [0 -1 0 0 0 0];
fml1.preds(2).b = -2.99;
fml1.stopTime = Parameter.Time.TMax;

% Formula 2, maximum pitch angle
fml2 = struct(tmpl);
fml2.expName = 'fml2';
fml2.targetFormula = '[]_[30, 630]p1';
fml2.monitoringFormula = 'p1';

fml2.preds(1).str = 'p1';
fml2.preds(1).A = [0 0 0 0 0 1];
fml2.preds(1).b = 14.2;
fml2.stopTime = Parameter.Time.TMax;

% Formula 3, gnerator torque
fml3 = struct(tmpl);
fml3.expName = 'fml3';
fml3.targetFormula = '[]_[30, 630](p1 /\ p2)';
fml3.monitoringFormula = 'p1 /\ p2';

fml3.preds(1).str = 'p1';
fml3.preds(1).A = [0 0 1 0 0 0];
fml3.preds(1).b = 4.75*10^4;
fml3.preds(2).str = 'p2';
fml3.preds(2).A = [0 0 -1 0 0 0];
fml3.preds(2).b = -2.10*10^4;
fml3.stopTime = Parameter.Time.TMax;

% Formula 4, rotor speed
fml4 = struct(tmpl);
fml4.expName = 'fml4';
fml4.targetFormula = '[]_[30, 630](p1)';
fml4.monitoringFormula = 'p1';

fml4.preds(1).str = 'p1';
fml4.preds(1).A = [0 0 0 0 1 0];
fml4.preds(1).b = 14.3;
fml4.stopTime = Parameter.Time.TMax;

% Formula 5, difference between the command pitch and the measuread pitch
fml5 = struct(tmpl);
fml5.expName = 'fml5';
fml5.targetFormula = '[]_[30, 630](<>_[0,5](p1 /\ p2))';
fml5.monitoringFormula = '[.]_[50, 50](<>_[0,50](p1 /\ p2))';

fml5.preds(1).str = 'p1';
fml5.preds(1).A = [-1 0 0 0 0 1];
fml5.preds(1).b = 1.62;
fml5.preds(2).str = 'p2';
fml5.preds(2).A = [1 0 0 0 0 -1];
fml5.preds(2).b = 1.62;
fml5.stopTime = Parameter.Time.TMax;

fmls = {fml1};

% Algorithms
%algorithms = { {'RL', 'DDQN', 'SimplifiedWTModelRL'}};
%, {'s-taliro', 'SA', 'SimplifiedWTModelSTaLiRo'}};
algorithms = {{'s-taliro', 'SA', 'SimplifiedWTModelFALS'},...
    {'s-taliro', 'CE', 'SimplifiedWTModelFALS'}};

% Other parameters
sampleTime = 5;

% Generate configurations
configs = {};
for i = 1:size(fmls, 2)
    for j = 1:size(algorithms, 2)
        config = struct(fmls{i});
        config.mdl = algorithms{j}{3};
        config.algoName = [algorithms{j}{1}, '-', algorithms{j}{2}];
        config.sampleTime = sampleTime;
        config.engine = algorithms{j}{1};
        config.option = algorithms{j}{2};
        for l = 1:maxIter
           configs = [configs, config];
        end
    end
end

do_experiment('s-taliro-wind-turbine', configs);

function do_experiment(name, configs, br_configs)
 results = table('Size', [0 6],...
     'VariableTypes', {'string', 'string', 'int32', 'int32', 'double', 'double'},...
     'VariableNames', {'expName', 'algoName', 'sampleTime',...
     'numEpisode', 'elapsedTime', 'bestRob'});
 global workers_num logDir;
 [~,git_hash_string] = system('git rev-parse HEAD');
 git_hash_string = strrep(git_hash_string,newline,'');
 logFile = fullfile(logDir, [name, '-', datestr(datetime('now'), 'yyyy-mm-dd-HH-MM'), '-', git_hash_string, '.csv']);
 if workers_num > 1
     for retry_num = 1:100
         delete(gcp('nocreate'));
         parpool(workers_num);
         p = gcp();
         disp(size(configs, 2));
         clear F;
         for idx = 1:size(configs, 2)
            F(idx) = parfeval(p, @falsify_any,3,configs{idx});
         end
         returned = [ ];
         for idx = 1:size(configs, 2)
             try
                if idx > workers_num * 2
                    exc = MException();
                    throw(exc);
                end
                [completedIdx, ...
                    numEpisode, elapsedTime, bestRob] ...
                    = fetchNext(F);
             catch ME
                 disp(ME.identifier);
                 disp(ME.message);
                 break;
             end
            % store the result
            config = configs{completedIdx};
            result = {config.expName, config.algoName, config.sampleTime,...
                numEpisode, elapsedTime, bestRob};
            results = [results; result];
            writetable(results, logFile);
            returned = [returned; completedIdx];
            % update waitbar
         end
         old_configs = configs;
         configs = {};
         for idx = 1:size(old_configs, 2)
             if ~ismember(idx, returned)
                 configs = [configs, old_configs{idx}];
             end
         end
         if size(configs, 2) == 0
            break;
         end
     end
     delete(gcp('nocreate'));
 else
     for i = 1:size(configs, 2)
        config = configs{i};
        [numEpisode, elapsedTime, bestRob] = ...
            falsify_any(config);
        result = {config.expName, config.algoName, config.sampleTime,...
            numEpisode, elapsedTime, bestRob};
        results = [results; result];
        writetable(results, logFile);
     end
 end
end

function [numEpisode, elapsedTime, bestRob] = falsify_any(config)
    for i = 1:size(config.init_opts, 2)
       assignin('base', config.init_opts{i}{1}, config.init_opts{i}{2});
    end
    if strcmp(config.engine, 's-taliro')
        [numEpisode, elapsedTime, bestRob, ~, ~] = falsify_staliro(config);
    else
      assert(false);
    end
end

function [numEpisode, elapsedTime, bestRob, bestXout, bestYout] = falsify_staliro(config)
    opt = staliro_options();
    opt.interpolationtype = config.interpolation;
    opt.fals_at_zero = 0;
    if strcmp(config.option, 'CE')
        opt.optimization_solver = 'CE_Taliro';
    end
    opt.optim_params.n_tests = config.maxEpisodes;
    [results, ~, ~] = staliro(config.mdl,[], config.input_range, ...
        repelem(config.stopTime / config.sampleTime, size(config.input_range, 1)),...
        config.targetFormula, config.preds, config.stopTime, opt);
    numEpisode = results.run.nTests;
    elapsedTime = results.run.time;
    bestRob = results.run.bestRob;
    bestXout = results.run.bestSample;
    bestYout = [];
end

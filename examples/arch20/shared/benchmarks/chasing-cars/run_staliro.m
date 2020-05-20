% (C) 2019 National Institute of Advanced Industrial Science and Technology
% (AIST)

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


% cars Benchmark
%%%%%%%%%%%%%%%%%%%%

cars_tmpl = struct(config_tmpl);
cars_tmpl.outputs = [1 2 3 4];
cars_tmpl.input_range = [0.0 1.0; 0.0 1.0];
cars_tmpl.output_range = [0 -100; 0 -100; 0 -100; 0 -100; 0 -100];
cars_tmpl.init_opts = {};
cars_tmpl.interpolation = {'pconst'};
algomdls = {{'s-taliro', 'CE', 'cars'}, {'s-taliro', 'SA', 'cars'}};
%     {'RL', 'RAND', 'autotrans_mod04'},...
%     {'RL', 'A3C', 'autotrans_mod04'}, {'RL', 'DDQN', 'autotrans_mod04'},...
%    {'s-taliro', 'SA', 'cars_staliro'}, {'s-taliro', 'CE', 'cars_staliro'}};
sampleTimes = [5];

% Formula 1
% Invariant
fml1 = struct(cars_tmpl);
fml1.expName = 'fml1';
fml1.targetFormula = '[]p1';

fml1.preds(1).str = 'p1';
fml1.preds(1).A = [0 0 0 -1 1];
fml1.preds(1).b = 40.0;
fml1.stopTime = 100;

% Formula 2
% Guarantee
fml2 = struct(cars_tmpl);
fml2.expName = 'fml2';
fml2.targetFormula = '[]_[0,70]<>_[0,30]p1';

fml2.preds(1).str = 'p1';
fml2.preds(1).A = [0 0 0 -1 1];
fml2.preds(1).b = -15;

fml2.stopTime = 100;

%Formula 3
% Obligation
fml3 = struct(cars_tmpl);
fml3.expName = 'fml3';
fml3.targetFormula = '[]_[0,80](([]_[0,20]p1) \/ (<>_[0,20]p2))';

fml3.preds(1).str = 'p1';
fml3.preds(1).A = [-1 1 0 0 0];
fml3.preds(1).b = 20;
fml3.preds(2).str = 'p2';
fml3.preds(2).A = [0 0 0 -1 1];
fml3.preds(2).b = -40;

fml3.stopTime = 100;

%Formula 4
%Persistence
fml4 = struct(cars_tmpl);
fml4.expName = 'fml4';
fml4.targetFormula = '[]_[0,65]<>_[0,30][]_[0,5]p1';
fml4.preds(1).str = 'p1';
fml4.preds(1).A = [0 0 0 -1 1];
fml4.preds(1).b = -8;
fml4.stopTime = 100;

%Formula 5
%Reactivity
fml5 = struct(cars_tmpl);
fml5.expName = 'fml5';
fml5.targetFormula = '[]_[0,72]<>_[0,8]([]_[0,5]p1 -> []_[5,20]p2)';
fml5.stopTime = 100;
fml5.preds(1).str = 'p1';
fml5.preds(1).A = [-1 1 0 0 0];
fml5.preds(1).b = -9;
fml5.preds(2).str = 'p2';
fml5.preds(2).A = [0 0 0 -1 1];
fml5.preds(2).b = -9;

formulas = {fml1};
%formulas = {fml1, fml2, fml3, fml4, fml};

configs = { };
for k = 1:size(formulas, 2)
    for i = 1:size(algomdls, 2)
        for j = 1:size(sampleTimes, 2)
            config = struct(formulas{k});
            config.mdl = algomdls{i}{3};
            config.algoName = [algomdls{i}{1}, '-', algomdls{i}{2}];
            config.sampleTime = sampleTimes(j);
            config.engine = algomdls{i}{1};
            config.option = algomdls{i}{2};
            for l = 1:maxIter
              configs = [configs, config];
            end
        end
    end
end

do_experiment('cars', configs, {});

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

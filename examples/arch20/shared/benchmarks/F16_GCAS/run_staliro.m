clear;
close all;
global analysisOn,
global printOn, 
global plotOn,
global model_err 
global InitAlt

InitAlt = 4040;
model_err = false;

analysisOn = false;
printOn = false;
plotOn = false;
backCalculateBestSamp = false;

% Simulation time & Requirements (run " help staliro" for more information)
t0 = 0;
tf = 15;
pred(1).str = 'p1';  
pred(1).A =  -1;
pred(1).b =  0;  
phi = '[]_[0,15] p1'; % Make sure you specify the output mapping and its derivative if the requirement is not on the states
model = @blackboxF16;            % Black box model that calls Simulink through staliro
nbstarts = 100;                   % # of Runs
nbiter = 1000;                   % Max # of simulations

% Search space for aircraft's initial conditions   
Xrange = [pi/4+[-pi/20 pi/30]; -(pi/2)*0.8+[0 pi/20]; -pi/4+[-pi/8 pi/8]];

% Staliro's options
opt = staliro_options(); %(See staliro_options help file)
opt.runs = nbstarts;
opt.black_box = 1;
opt.optim_params.n_tests = nbiter;

[results, history] = staliro(model,Xrange,[],[],phi,pred,tf,opt);

if backCalculateBestSamp
    analysisOn = true; %#ok<UNRCH>
    printOn = true;
    plotOn = true;
    [T, XT, YT, LT, CLG, Guards] = blackboxF16(results.run.bestSample,tf,[],[]);
    MakeAnimation
end

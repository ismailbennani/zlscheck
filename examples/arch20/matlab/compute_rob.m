function r = compute_rob(phi,preds,u)
    addpath(genpath("/home/lahkim/Documents/MATLAB/toolbox/S-TALIRO"));
    
    T = u(end, 1);
    cd ../shared/benchmarks/transmission;
    [tout, yout] = run_transmission(u, T);
    cd ../../../matlab;

    r = dp_taliro(phi,preds,yout,tout);
end

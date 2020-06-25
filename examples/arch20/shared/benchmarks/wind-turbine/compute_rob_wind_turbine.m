function [tout, u_, yout, r] = compute_rob_wind_turbine(phi,preds,u)
    T_end = u(end, 1);
    t = u(:,1);
    u = u(:,2);
    
    [tout, yout] = run_wind_turbine([t u], T_end);
    
    T = tout;
    u_(:,1) = interp1(t, u(:,1), T, 'previous');
    YT = yout;

    r = dp_taliro(phi,preds,YT,T);
end

function [tout, u_, yout, r] = compute_rob_powertrain(phi,preds,u)
    T_end = u(end, 1);
    t = u(:,1);
    u = u(:,2:3);
    [tout, yout] = run_powertrain([t u], T_end);

    T = tout;
    u_(:,1) = interp1(t, u(:,1), T, 'previous');
    u_(:,2) = interp1(t, u(:,2), T, 'previous');
    YT = yout;
    
    r = dp_taliro(phi,preds,YT,T);
end

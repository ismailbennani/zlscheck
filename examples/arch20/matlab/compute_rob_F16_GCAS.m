function [tout, u_, yout, r] = compute_rob_F16_GCAS(phi,preds,u)
    T_end = u(end, 1);
    t = u(:,1);
    u = u(:,2:4);
    [tout, yout] = run_f16(4040, 540, u(1,1), u(1,2), u(1,3) , T_end);

    T = tout';
    u_(:,1) = interp1(t, u(:,1), T, 'previous');
    u_(:,2) = interp1(t, u(:,2), T, 'previous');
    u_(:,3) = interp1(t, u(:,3), T, 'previous');
    YT = yout';
    
    tout = tout';
    yout = yout';
    
    r = dp_taliro(phi,preds,YT,T);
end

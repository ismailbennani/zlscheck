function [tout, u_, yout, r] = compute_rob_transmission(phi,preds,u)
    T_end = u(end, 1);
    t = u(:,1);
    u = u(:,2:3);
    [tout, yout] = run_transmission([t u], T_end);

    T = tout;
    u_(:,1) = interp1(t, u(:,1), T, 'previous');
    u_(:,2) = interp1(t, u(:,2), T, 'previous');
    YT = yout(:,1:2);
    LT = yout(:,3);

    CLG{1} = 2;
    CLG{2} = [1,3];
    CLG{3} = [2,4];
    CLG{4} = 3;
    
    r = dp_taliro(phi,preds,YT,T,LT,CLG);
end

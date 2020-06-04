function r = compute_rob(phi,preds,u)
    T_end = u(end, 1);
    u = u(:,1:3);
    [tout, yout] = run_transmission(u, T_end);

    T = tout;
    YT = yout(:,1:2);
    LT = yout(:,3);

    CLG{1} = 2;
    CLG{2} = [1,3];
    CLG{3} = [2,4];
    CLG{4} = 3;
    
    r = dp_taliro(phi,preds,YT,T,LT,CLG);
end

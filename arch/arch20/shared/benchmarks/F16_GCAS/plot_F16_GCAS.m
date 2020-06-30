function [out] = plot_F16_GCAS(u)
    T = u(end, 1);
    u = u(:,1:4);
    
    addpath("../shared/benchmarks/F16_GCAS");
    [tout, yout] = run_f16(4040, 540, u(1,2), u(1,3), u(1,4) ,T);
    
    u_(:,1) = tout';
    u_(:,2) = interp1(u(:,1), u(:,2), tout, 'previous');
    u_(:,3) = interp1(u(:,1), u(:,3), tout, 'previous');
    u_(:,4) = interp1(u(:,1), u(:,4), tout, 'previous');
    
    out = [u_ yout'];
    
    figure;
    plot(tout', yout(1,:));
    title('altitude');
end


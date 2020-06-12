function [out] = plot_chasingcars(u)
    T = u(end, 1);
    u = u(:,1:3);
    
    addpath("../shared/benchmarks/chasingcars");
    [tout, yout] = run_cars(u, T);
    
    u_(:,1) = tout;
    u_(:,2) = interp1(u(:,1), u(:,2), tout, 'previous');
    u_(:,3) = interp1(u(:,1), u(:,3), tout, 'previous');
    
    out = [u_ yout];
    
    figure;
    
    subplot(2,1,1);
    plot(u_(:,1), u_(:,2), u_(:,1), u_(:,3));
    title('throttle and brake');
    
    subplot(2,1,2);
    plot(tout, yout(:,1), tout, yout(:,2), tout, yout(:,3),...
         tout, yout(:,4), tout, yout(:,5));
    title('cars');
end


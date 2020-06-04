function [out] = plot_transmission(u)
    T = u(end, 1);
    u = u(:,1:3);
    
    addpath("../shared/benchmarks/transmission");
    [tout, yout] = run_transmission(u, T);
    
    up_th = interp2([0 25 35 50 90 100], 1:4, [10 30 50 1000000; 10 30 50 1000000; 15 30 50 1000000; 23 41 60 1000000; 40 70 100 1000000; 40 70 100 1000000]', u(:,2), yout(:,3));
    down_th = interp2([0 25 35 50 90 100], 1:4, [0 5 20 35; 0 5 20 35; 0 5 25 40; 0 5 30 50; 0 30 50 80; 0 30 50 80]', u(:,2), yout(:,3));
    
    out = [u yout]
    
    figure
    
    subplot(4,1,1);
    plot(u(:,1), u(:,2), u(:,1), u(:,3))
    title('throttle and brake')
    
    subplot(4,1,2);
    plot(tout, yout(:,2), [0 T], [3000,3000])
    title('rpm')
    
    subplot(4,1,3);
    plot(tout, yout(:,3))
    title('gear')
    
    subplot(4,1,4);
    plot(tout, yout(:,1), tout, down_th, [0 T], [35,35])
    title('speed')
end


function [out] = plot_powertrain(u)
    T = u(end, 1);
    
    tout = u(:,1);
    xin = interp1(tout, u(:,2:3), tout, 'previous');
    yout = u(:,4:end);
    
    out = [xin yout];
    
    figure
    
    subplot(5,1,1);
    plot(tout, xin(:,1), [0 T], [8.8, 8.8], [0 T], [40, 40])
    title('throttle')
    
    subplot(5,1,2);
    plot(tout, xin(:,2))
    title('engine')
    
    subplot(5,1,3);
    plot(tout, yout(:,4), tout, yout(:,5))
    title('abf')
    
    subplot(5,1,4);
    plot(tout, yout(:,2), [0 T], [0.008, 0.008], [0 T], [-0.008, -0.008], [0 T], [0.007, 0.007], [0 T], [-0.007, -0.007])
    title('mu')
    
    subplot(5,1,5);
    plot(tout, yout(:,3))
    title('mode')
end


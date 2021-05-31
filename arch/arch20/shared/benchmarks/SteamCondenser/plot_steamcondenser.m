function [out] = plot_steamcondenser(u)
    T = u(end, 1);
    
    tout = u(:,1);
    xin = interp1(tout, u(:,2), tout, 'previous');
    yout = u(:,3:end);
    
    out = u;
    
    figure;
    
    subplot(2,1,1);
    plot(tout, xin);
    title('Fs');
    
    subplot(2,1,2);
    plot(tout, yout(:,1), [0 40], [87 87], [0 40], [87.5 87.5]);
    title('P');
end


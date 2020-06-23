function [out] = plot_neural(u)
    T = u(end, 1);
    
    tout = u(:,1);
    xin = interp1(tout, u(:,2), tout, 'previous');
    yout = u(:,3:end);
    
    out = [xin yout];
    
    figure
    
    margin = 0.005 + (0.03 * abs(xin))
    
    subplot(5,1,1);
    plot(tout, xin(:,1), tout, yout(:,1), tout, xin(:,1)+margin, tout, xin(:,1)-margin)
    title('pos')
    
    subplot(5,1,2);
    plot(tout, yout(:,2))
    title('nnpos')
end


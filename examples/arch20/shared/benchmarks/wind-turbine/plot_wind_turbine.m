function [out] = plot_wind_turbine(u)
    T = u(end, 1);
    
    tout = u(:,1);
    xin = interp1(tout, u(:,2), tout, 'previous');
    yout = u(:,3:end);
    
    out = u;
    
    figure;
    
    subplot(6,1,1);
    plot(tout, xin);
    title('v0');
    
    subplot(6,1,2);
    plot(tout, yout(:,2), [0 630], [14.3 14.3]);
    title('omega');
    
    subplot(6,1,3);
    plot(tout, yout(:,3), [0 630], [21000 21000], [0 630], [47500 47500]);
    title('mg_d');
    
    subplot(6,1,4);
    plot(tout, yout(:,4));
    title('omega_g');
    
    subplot(6,1,5);
    plot(tout, yout(:,5));
    title('theta_d');
    
    subplot(6,1,6);
    plot(tout, yout(:,6));
    title('blade pitch angle');
end


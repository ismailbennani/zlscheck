function [out] = plot_wind_turbine(u)
    T = u(end, 1);
    
    size(u)
    
    u = u(:,1:2);
    
    size(u)
    
    addpath("../shared/benchmarks/wind_turbine");
    [tout, yout] = run_wind_turbine(u, T);
    
    u_(:,1) = tout;
    u_(:,2) = interp1(u(:,1), u(:,2), tout, 'previous');
    
    out = [u_ yout];
    
    figure;
    
    subplot(5,1,1);
    plot(u_(:,1), u_(:,2));
    title('v0');
    
    subplot(5,1,2);
    plot(tout, yout(:,2));
    title('omega');
    
    subplot(5,1,3);
    plot(tout, yout(:,3));
    title('omega_g');
    
    subplot(5,1,4);
    plot(tout, yout(:,4));
    title('theta_d');
    
    subplot(5,1,5);
    plot(tout, yout(:,5));
    title('blade pitch angle');
end


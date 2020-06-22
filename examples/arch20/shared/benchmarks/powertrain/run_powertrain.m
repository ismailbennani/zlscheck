function [tout, yout] = run_powertrain(u, T)
    ts = u(:,1);
    us = u(:,2:end);
    
    tin = 0:0.01:T;
    xin = interp1(ts, us, tin, 'previous');
    u = [tin' xin];
    
    init_powertrain;
    assignin('base','simTime', simTime);
    assignin('base','measureTime', measureTime);
    assignin('base','fault_time', fault_time);
    assignin('base','spec_num', spec_num);
    assignin('base','fuel_inj_tol', fuel_inj_tol);
    assignin('base','MAF_sensor_tol', MAF_sensor_tol);
    assignin('base','AF_sensor_tol', AF_sensor_tol);
    
    assignin('base','u',u);
    assignin('base','T',T);
    
    result = sim('AbstractFuelControl_M1', ...
        'StopTime', 'T', ...
        'LoadExternalInput', 'on', 'ExternalInput', 'u', ...
        'SaveTime', 'on', 'TimeSaveName', 'tout', ...
        'SaveOutput', 'on', 'OutputSaveName', 'yout', ...
        'SaveFormat', 'Array');
    tout = result.tout;
    yout = result.yout;
end

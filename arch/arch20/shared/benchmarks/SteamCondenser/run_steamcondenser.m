function [tout, yout] = run_steamcondenser(u, T)
    ts = u(:,1);
    us = u(:,2:end);
    
    tin = 0:0.01:T;
    xin = interp1(ts, us, tin, 'previous');
    u = [tin' xin'];
    
    assignin('base','u',u);
    assignin('base','T',T);
    
    result = sim('steamcondense_RNN_22_ZLS', ...
        'LoadExternalInput', 'on', 'ExternalInput', 'u', ...
        'SaveTime', 'on', 'TimeSaveName', 'tout', ...
        'SaveOutput', 'on', 'OutputSaveName', 'yout', ...
        'SaveFormat', 'Array');
    tout = result.tout;
    yout = result.yout;
end

classdef wind_signal_gen < signal_gen
   methods
       function this = wind_signal_gen()
           this.params = {'iBin', 'iRandSeed'};
           this.params_domain = [BreachDomain('enum', 1:11)  BreachDomain('enum', 1:3)];
           this.p0 = [1 1]';
           this.signals = {'v0'};
       end
   
       function X = computeSignals(this, p, time)
           % read common Parameter structure from the workspace 
           Parameter = evalin('base', 'Parameter'); % assumes init_SimpleWindTurbine has been run
           v0_cell = evalin('base', 'v0_cell');
           
           % parameters from Breach: bin and seed indices
           iBin = p(1);
           iRandSeed = p(2);
       
           % get the wind signal from indices and update Parameter
           Parameter.v0                        = v0_cell{iBin,iRandSeed};
           Parameter.v0.signals.values         = Parameter.v0.signals.values';
           Parameter.TMax                      = v0_cell{iBin,iRandSeed}.time(end);
           Parameter.Time.cut_out              = Parameter.Time.TMax;
           Parameter.v0_0 = Parameter.v0.signals.values(1);           
           Parameter = SimplifiedTurbine_ParamterFile(Parameter);
           assignin('base', 'Parameter', Parameter); 
       
           % get wind signal for Breach 
           X = interp1(Parameter.v0.time, Parameter.v0.signals.values, time,'previous','extrap');
           
       end
       
   end
    
    
end
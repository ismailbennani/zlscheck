classdef wind_rand_signal_gen < random_signal_gen
   methods
   
       function this=  wind_rand_signal_gen()
           this = this@random_signal_gen('v0', 'spline',[1 5 5 8 16]);
       end

       function X = computeSignals(this, p, time)
            X = computeSignals@random_signal_gen(this, p, time);
            
            % read common Parameter structure from the workspace 
           Parameter = evalin('base', 'Parameter'); % assumes init_SimpleWindTurbine has been run
           
           % get the wind signal from indices and update Parameter
           
           Parameter.v0.time                   = time;
           Parameter.v0.signals.dimension      = 1;
           Parameter.v0.signals.values         = X';
           Parameter.TMax                      = time(end);
           Parameter.Time.cut_out              = Parameter.Time.TMax;
           Parameter.v0_0 = Parameter.v0.signals.values(1);           
           Parameter = SimplifiedTurbine_ParamterFile(Parameter);
           assignin('base', 'Parameter', Parameter); 
            
       end
       
   end
   
    
    
end
    
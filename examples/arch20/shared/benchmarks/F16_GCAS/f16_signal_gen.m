classdef f16_signal_gen < signal_gen
% Wrapper class for F16 
    
    methods
        
        function this = f16_signal_gen()
            this.params = {'altg', 'Vtg','phig', 'thetag', 'psig'};
            this.p0 = [4040;...
                540;...  % Pass at Vtg = 540;    Fail at Vtg = 550;
                (pi/2)*0.5;...       % Roll angle from wings level (rad)
                -(pi/2)*0.8;...      % Pitch angle from nose level (rad)
                -(pi/4)];            % Yaw angle from North (rad)
            
            this.signals = {'altitude'}; % starting with bare minimum for benchmark
            
            
            
        end
        
        function X = computeSignals(this, p, t_vec)
            
            %% Default constant parameters 
            powg = 9;                   % Power            
            % Default alpha & beta
            alphag = deg2rad(2.1215);   % Trim Angle of Attack (rad)
            betag = 0;                  % Side slip angle (rad)

            %% Connect parameters from Breach to those of F16
            altg = p(1);
            Vtg = p(2);             
            phig = p(3);        
            thetag = p(4);      
            psig = p(5);        
            
            %% Set Flight & Ctrl Limits (for pass-fail conditions)
            [flightLimits,ctrlLimits,autopilot] = getDefaultSettings();
            ctrlLimits.ThrottleMax = 0.7;   % Limit to Mil power (no afterburner)
            autopilot.simpleGCAS = true;    % Run GCAS simulation
            
            %% Build Initial Condition Vectors
            initialState = [Vtg alphag betag phig thetag psig 0 0 0 0 0 altg powg];
            orient = 4;             % Orientation for trim
            analysisOn=false;
            printOn = false;
            plotOn = false;
            
            %% Run Desired F-16 Plant
            % Table Lookup
            output = RunF16Sim(initialState, t_vec, orient, 'stevens',...
                flightLimits, ctrlLimits, autopilot, analysisOn, printOn, plotOn);
            
            X = output(12,:);
            
        end
        
    end
    
end
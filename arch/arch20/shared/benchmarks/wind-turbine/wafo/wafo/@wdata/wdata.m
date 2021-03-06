function  Hs = wdata(data,args)
%WDATA WDATA class Constructor
%
% CALL hs = wdata(data,args)
%
% WDATA is a container for data objects in WAFO
% 
% Example
% x = -2:.2:2; y = -2:.25:2; z = -2:.16:2;
% [X,Y,Z] = meshgrid(x,y,z);
% d = wdata(X .* exp(-X.^2 - Y.^2 - Z.^2),{x,y,z}); 
% isosurface(d,0.3)
% d.isosurface(-0.3) % alternative call
% alpha(0.2)
%
% % Plot 2 objects in one call
% d2 = wdata(sin(x),x);
% d2(2) = wdata(cos(x+5),x+5);
% am = {d2.argMax} % nargout==2 in subsref
% am1 = {d2(1:2).argMax} %Note returns only 1'st value due to a BUG in matlab
% plot(d2)          % plot 2 figures
% figure(3)
% hold on, d2.plot; % plot both objects in the same figure
%
% % Plot with confidence interval
% d3 = wdata(sin(x),x); 
% d3 = set(d3,'dataCI',[sin(x(:))*0.9 sin(x(:))*1.2]);
% plot(d3)
%
% See also wdata/plot, specdata, covdata


% Tested on: matlab 7, 8, 9
% History:
% revised pab updated help header
% By pab Jan 2007

%error(nargchk(0,2,nargin));
narginchk(0,2)

thisClass = mfilename;
switch nargin
  case 0
    Hs = class(wdatastruct,thisClass);
  case 1
    switch class(data)
      case 'wdata'
        Hs = data;
      case 'struct'
        % Convert from struct to wdata object
        legalNames = fieldnames(wdatastruct);
        fn = fieldnames(data);       
        if all(ismember(legalNames,fn))
          notmember = (~ismember(fn,legalNames));
          if any(notmember)
            txt = sprintf(' %s,',fn{notmember});
            txt(end) = '.';
            warning('WAFO:WDATA','This data field is discared in the type conversion:\n%s',txt)
            Hs = class(parseoptions(wdatastruct,data),thisClass);
          else
            Hs = class(data,thisClass);
          end
           Hs = settype(Hs);
        elseif all(ismember({'f','x','labx','title','note','date'},fn));
          %oldPdfStruct
          if length(data.x)<=1
            Hs = wdata(data.f,data.x{:});
          else
            Hs = wdata(data.f,data.x(:).');
          end
          Hs.labels = data.labx(:).';
          Hs.title = data.title;
          Hs.note = data.note;
          Hs.date = data.date;
          if any(strcmpi(fn,'pl'))
            Hs.percentLevels = data.pl(:).';
          end
          if any(strcmpi(fn,'cl'))
            Hs.contourLevels = data.cl(:).';
          end    
          
          % Save additional fields in workspace
          iz = find(~ismember(fn,{'f','x','labx','title','note','date','pl','cl'}));
          if any(iz)        
            for ix = iz(:).'
              addfn.(fn{ix}) = data.(fn{ix});
            end
            Hs.workspace = addfn;
          end     
        else
          Hs = wdatastruct;
          Hs = parseoptions(Hs(ones(size(data))),data);
          Hs = class(Hs,'wdata');
        end
      otherwise
        Hs = wdatastruct;
        Hs.data = data;
        Hs = class(Hs,'wdata');
    end
  case 2
    Hs = parseoptions(wdatastruct,'data',data,'args',args);
    Hs = class(Hs,thisClass);
    Hs = settype(Hs);
    Hs = setsamplinginfo(Hs);
end



  

function  Hs1 = wdatastruct
%WDATASTRUCT Struct defining legal names and default values for a WDATA object

Hs1 = createwdata;
%  Hs1 = struct('name','WAFO data object',...
%     'type','data',...
%     'data',[],...
%     'dataCI',[],...
%     'args',[],...
%     'argMin',[],...
%     'argMax',[],...
%     'sampleRate',nan,...
%     'labels',[],...
%     'title','',...
%     'contourLevels',[],...
%     'percentLevels',[],...
%     'workspace',[],...
%     'info',[],...
%     'note','',...
%     'date',datestr(now));
%   Hs1.args = {};
%   Hs1.labels = {};
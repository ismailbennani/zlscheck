
AT{1} = '[]_[0,20] speed120';
AT{2} = '[]_[0,10] rpm4750';
AT{3} = '[]_[0, 30] ((!(gear1) /\ X (gear1))-> X []_[0, 2.5] (gear1))';
AT{4} = '[]_[0, 30] ((!(gear2) /\ X (gear2))-> X []_[0, 2.5] (gear2))';
AT{5} = '[]_[0, 30] ((!(gear3) /\ X (gear3))-> X []_[0, 2.5] (gear3))';
AT{6} = '[]_[0, 30] ((!(gear4) /\ X (gear4))-> X []_[0, 2.5] (gear4))';
AT{7} = '([]_[0, 30] (rpm3000) ->[]_[0, 4] (speed35))';
AT{8} = '([]_[0, 30] (rpm3000) ->[]_[0, 8] (speed50))';
AT{9} = '([]_[0, 30] (rpm3000) ->[]_[0, 20] (speed65))';

ii = 1;
preds(ii).str = 'gear1';
preds(ii).A = [];
preds(ii).b = [];
preds(ii).loc = 1;

ii = ii+1;
preds(ii).str = 'gear2';
preds(ii).A = [];
preds(ii).b = [];
preds(ii).loc = 2;

ii = ii+1;
preds(ii).str = 'gear3';
preds(ii).A = [];
preds(ii).b = [];
preds(ii).loc = 3;

ii = ii+1;
preds(ii).str = 'gear4';
preds(ii).A = [];
preds(ii).b = [];
preds(ii).loc = 4;

ii = ii+1;
preds(ii).str='speed120';
preds(ii).A = [1 0];
% preds(ii).A = [1];
% preds(ii).proj = 1;
preds(ii).b = 120;
preds(ii).loc = 1:4;

ii = ii+1;
preds(ii).str='speed35';
preds(ii).A = [1 0];
% preds(ii).A = [1];
% preds(ii).proj = 1;
preds(ii).b = 35;
preds(ii).loc = 1:4;

ii = ii+1;
preds(ii).str='speed50';
preds(ii).A = [1 0];
% preds(ii).A = [1];
% preds(ii).proj = 1;
preds(ii).b = 50;
preds(ii).loc = 1:4;

ii = ii+1;
preds(ii).str='speed65';
preds(ii).A = [1 0];
% preds(ii).A = [1];
% preds(ii).proj = 1;
preds(ii).b = 65;
preds(ii).loc = 1:4;


ii = ii+1;
preds(ii).str='rpm3000';
preds(ii).A = [0 1];
% preds(ii).A = [1];
% preds(ii).proj = 2;
preds(ii).b = 3000;
preds(ii).loc = 1:4;

ii = ii+1;
preds(ii).str='rpm4750';
preds(ii).A = [0 1];
% preds(ii).A = [1];
% preds(ii).proj = 2;
preds(ii).b = 4750;
preds(ii).loc = 1:4;

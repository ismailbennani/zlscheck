% Invariant
CC{1} = '[]p1';
% Guarantee
CC{2} = '[]_[0,70]<>_[0,30]p2';
% Obligation
CC{3} = '[]_[0,80](([]_[0,20]p3) \/ (<>_[0,20]p4))';
%Persistence
CC{4} = '[]_[0,65]<>_[0,30][]_[0,5]p5';
%Reactivity
CC{5} = '[]_[0,72]<>_[0,8]([]_[0,5]p1 -> []_[5,20]p2)';

preds(1).str = 'p1';
preds(1).A = [0 0 0 -1 1];
preds(1).b = 40.0;

preds(2).str = 'p2';
preds(2).A = [0 0 0 -1 1];
preds(2).b = -15;

preds(3).str = 'p3';
preds(3).A = [-1 1 0 0 0];
preds(3).b = 20;

preds(4).str = 'p4';
preds(4).A = [0 0 0 -1 1];
preds(4).b = -40;

preds(5).str = 'p5';
preds(5).A = [0 0 0 -1 1];
preds(5).b = -8;

preds(6).str = 'p6';
preds(6).A = [-1 1 0 0 0];
preds(6).b = -9;

preds(7).str = 'p7';
preds(7).A = [0 0 0 -1 1];
preds(7).b = -9;
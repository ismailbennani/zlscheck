
AT{1} = '[]_[0,20] speed120';
AT{2} = '[]_[0,10] rpm4750';
AT{3} = '[]_[0, 30] ((!(gear1) /\ X (gear1))-> X []_[0, 2.5] (gear1))';
AT{4} = '[]_[0, 30] ((!(gear2) /\ X (gear2))-> X []_[0, 2.5] (gear2))';
AT{5} = '[]_[0, 30] ((!(gear3) /\ X (gear3))-> X []_[0, 2.5] (gear3))';
AT{6} = '[]_[0, 30] ((!(gear4) /\ X (gear4))-> X []_[0, 2.5] (gear4))';
AT{7} = '([]_[0, 30] (rpm3000) ->[]_[0, 4] (speed35))';
AT{8} = '([]_[0, 30] (rpm3000) ->[]_[0, 8] (speed50))';
AT{9} = '([]_[0, 30] (rpm3000) ->[]_[0, 20] (speed65))';

preds(1).str = 'gear1';
preds(1).A = [];
preds(1).b = [];
preds(1).loc = 1;

preds(2).str = 'gear2';
preds(2).A = [];
preds(2).b = [];
preds(2).loc = 2;

preds(3).str = 'gear3';
preds(3).A = [];
preds(3).b = [];
preds(3).loc = 3;

preds(4).str = 'gear4';
preds(4).A = [];
preds(4).b = [];
preds(4).loc = 4;

preds(5).str='speed120';
preds(5).A = [1 0];
preds(5).b = 120;
preds(5).loc = 1:4;

preds(6).str='speed35';
preds(6).A = [1 0];
preds(6).b = 35;
preds(6).loc = 1:4;

preds(7).str='speed50';
preds(7).A = [1 0];
preds(7).b = 50;
preds(7).loc = 1:4;

preds(8).str='speed65';
preds(8).A = [1 0];
preds(8).b = 65;
preds(8).loc = 1:4;


preds(9).str='rpm3000';
preds(9).A = [0 1];
preds(9).b = 3000;
preds(9).loc = 1:4;

preds(10).str='rpm4750';
preds(10).A = [0 1];
preds(10).b = 4750;
preds(10).loc = 1:4;

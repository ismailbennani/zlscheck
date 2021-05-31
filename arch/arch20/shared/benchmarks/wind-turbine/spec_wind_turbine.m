% Formulas
%%%%%%%%%%%%%%%
% Formula 1, mnimum pitch angle (not in requirements.txt)

% Formula 2, maximum pitch angle
WT{1} = '[]_[30, 630]p1';
preds(1).str = 'p1';
preds(1).A = [0 0 0 0 0 1];
preds(1).b = 14.2;

% Formula 3, gnerator torque
WT{2} = '[]_[30, 630](p2 /\ p3)';

preds(2).str = 'p2';
preds(2).A = [0 0 1 0 0 0];
preds(2).b = 4.75*10^4;
preds(3).str = 'p3';
preds(3).A = [0 0 -1 0 0 0];
preds(3).b = -2.10*10^4;

% Formula 4, rotor speed
WT{3} = '[]_[30, 630](p4)';

preds(4).str = 'p4';
preds(4).A = [0 1 0 0 0 0];
preds(4).b = 14.3;

% Formula 5, difference between the command pitch and the measuread pitch
WT{4} = '[]_[30, 630](<>_[0,5](p5 /\ p6))';

preds(5).str = 'p5';
preds(5).A = [0 0 0 0 -1 1];
preds(5).b = 1.6;
preds(6).str = 'p6';
preds(6).A = [0 0 0 0 1 -1];
preds(6).b = 1.6;
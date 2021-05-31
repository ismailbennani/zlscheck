NN{1} = '[]_[1,37] (!(p1 /\ p2) -> <>_[0,2] ([]_[0,1] (p1 /\ p2)))';

alpha = 0.005;
beta = 0.03;

preds(1).str = 'p1';  
preds(1).A =  [1 -(beta+1) 0];
preds(1).b =  alpha;  
preds(2).str = 'p2';  
preds(2).A =  [-1 (beta+1) 0];
preds(2).b =  alpha;  
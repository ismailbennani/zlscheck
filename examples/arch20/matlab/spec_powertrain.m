
AFC{27} = '[]_[11,50] (((throttle8 /\ <>_[0,0.05] (throttle40)) \/ (throttle40 /\ <>_[0,0.05] (throttle8))) -> ([]_[1,5] (mu1 /\ mu2)))';
AFC{29} = '[]_[11,50] (mu3 /\ mu4)';
AFC{33} = AFC{29};

preds(1).str='mu1';
preds(1).A = [0 1 0];
preds(1).b = 0.008;

preds(2).str='mu2';
preds(2).A = [0 -1 0];
preds(2).b = 0.008;

preds(3).str='mu3';
preds(3).A = [0 1 0];
preds(3).b = 0.007;

preds(4).str='mu4';
preds(4).A = [0 -1 0];
preds(4).b = 0.007;

preds(3).str='throttle8';
preds(3).A = [1 0 0];
preds(3).b = 8.8;

preds(4).str='throttle40';
preds(4).A = [-1 0 0];
preds(4).b = -40;

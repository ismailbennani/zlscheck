% names of input signals
in  = ['x'];

% names of output signals
out = ['y', 'z'];

% row vector of time points
ts  = [0, 1, 2];

% two matrices for the input and output signal
us  = [1; 1; 2];
ys  = [1 2; 1 3; 2 4];

% formulas are in prefix notation without outer parentheses
falstar_validate(in, out, us, ys, '> x 1')
falstar_validate(in, out, us, ys, 'eventually (0 2) (<= x 1)')
falstar_validate(in, out, us, ys, 'always (0 2) (<= (+ x 0) 1)')

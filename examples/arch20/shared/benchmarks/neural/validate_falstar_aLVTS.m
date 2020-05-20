requirements;

results1 = readtable('../../../falstar/results1/nn.csv', 'ReadVariableNames', true);
results2 = readtable('../../../falstar/results2/nn.csv', 'ReadVariableNames', true);

for i = 1:size(results1)
    benchmark = results1.benchmark{i};
    robustness = results1.robustness(i);
    input = eval(results1.input{i});
    phi = evalin('base', benchmark);
    validate_neural(phi,robustness,input);
end

for i = 1:size(results2)
    benchmark = results2.benchmark{i};
    robustness = results2.robustness(i);
    input = eval(results2.input{i});
    phi = evalin('base', benchmark);
    validate_neural(phi,robustness,input);
end
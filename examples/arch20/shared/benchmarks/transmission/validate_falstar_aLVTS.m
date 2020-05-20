requirements;

results1 = readtable('../../../falstar/results1/at.csv', 'ReadVariableNames', true);

for i = 1:size(results1)
    benchmark = results1.benchmark{i};
    robustness = results1.robustness(i);
    input = eval(results1.input{i});
    phi = evalin('base', benchmark);
    validate_transmission(phi,robustness,input);
end
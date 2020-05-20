requirements;

results2 = readtable('../../../falstar/results2/afc.csv', 'ReadVariableNames', true);

for i = 1:size(results2)
    benchmark = results2.benchmark{i};
    robustness = results2.robustness(i);
    input = eval(results2.input{i});
    phi = evalin('base', benchmark);
    validate_powertrain(phi,robustness,input);
end
function [ok, notok] = validate_zlscheck_chasingcars(phi, preds, dump_folder)
    foldInfo = dir(fullfile(dump_folder, "*.csv"));

    n_dumps = length(foldInfo);

    fprintf("Found %d dumps\n", n_dumps);

    j = 1;
    ok = [];
    notok = [];

    for i = 1:n_dumps
        csvfile = fullfile(dump_folder,foldInfo(i).name);
        u = csvread(csvfile);

        [tout, u, yout, r] = compute_rob_chasingcars(phi, preds, u);
        
        if r >= 0
            fprintf("KO, input does not falsify %s\n", phi);
            notok(j).name = foldInfo(i).name;
            notok(j).u = [tout u yout];
            notok(j).r = r;
            j = j + 1;
        else
            ok(i - j + 1).name = foldInfo(i).name;
            ok(i - j + 1).u = [tout u yout];
            ok(i - j + 1).r = r;
        end
    end

    fprintf("OK: %d/%d\n", n_dumps - length(notok), n_dumps);

end

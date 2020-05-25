function ok = validate_zlscheck_transmission(phi, preds, dump_folder)
    foldInfo = dir(fullfile(dump_folder, "*.csv"));

    ok = true;
    for i = 1:length(foldInfo)
        csvfile = fullfile(dump_folder,foldInfo(i).name);

        fprintf("Processing %s...",csvfile)

        u = csvread(csvfile);
        u(1,:) = [];

        r = compute_rob(phi, preds, u);
        if r >= 0
            ok = false;
            fprintf("KO\ninput does not falsify %s\nrob: %f\n\n", phi,r)
        else
            fprintf("OK\n")
        end
    end

end

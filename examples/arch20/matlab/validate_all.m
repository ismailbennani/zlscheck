%%% COPY THIS SCRIPT UNDER ANY SUBFOLDER
%%% IT WILL SEARCH FOR ALL SCRIPTS NAMED "validate.m" RECURSIVELY
%%% AND EXECUTE THEM. RESULTS ARE STORED BY "validate.m" IN
%%% A VARIABLE CALLED "validation_results"

cur_fd = pwd;
validation_scripts = find_rec(".", "validate.m");
for i = 1:length(validation_scripts) 
    validation_script = validation_scripts(i);
    [folder, ~] = fileparts(validation_script);
    fprintf("Entering  %s...", folder);
    cd(folder); 
    run("validate.m");
end
cd(cur_fd);
clear cur_fd validation_scripts validation_script folder;
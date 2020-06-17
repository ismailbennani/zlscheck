function [paths] = find_rec(folder, file)
    sub_folders = dir(folder);
    sub_folders = sub_folders(~startsWith({sub_folders.name}, '.')); 
    dirs = [sub_folders.isdir];
    sub_folders = sub_folders(dirs);
    
    this_file = fullfile(folder, file);
    if isfile(this_file)
        paths = [this_file];
    else
        paths = [];
    end
    
    for i = 1:length(sub_folders)
        full_path = fullfile(sub_folders(i).folder, sub_folders(i).name);
        fprintf("Entering subfolder %s...\n", full_path);
        new_paths = find_rec(full_path, file);
        paths = [paths; new_paths];
    end
end


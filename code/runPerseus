function runPerseus(fname, mat, dim)
    [n m] = size(mat);
    mat = double(mat);
    vec = reshape(mat, [], 1);
    dlmwrite(fname, [dim; n; m; vec],'delimiter','\t');
    #cmd = ['./perseusMac cubtop ' fname ' ' fname]
    cmd = ['././perseusWin cubtop ' fname ' ' fname]
    system(cmd);
end

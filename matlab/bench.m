function bench()
% Add CORA to path
addpath(genpath('cora'));

% Intialize pseudo random number generator for repeatable results:
rng(31415);
% Run micro benchmark:
t_scalar = [];
t_matrix = [];
ns = 2:10:200;
for n=ns
    t_m = [];
    disp([mfilename '>> Running matrix operations for n = ' num2str(n)]);
    for k_run=1:100
        x = rand(n,1) + rand(n,1) .* interval(-ones(n,1), ones(n,1));
        P = rand(n,n) + rand(n,n) .* interval(-ones(n,n), ones(n,n));
        [t_scalar(end+1, 1), t_m(end+1, 1)] = runbench(x, P);
    end
    t_matrix = [t_matrix t_m];
end
t_matrix_min = min(t_matrix, [], 1);
save('benchresults.mat', 't_scalar', 't_matrix', 'ns');
results = load('benchresults.mat');
fid = fopen('benchresults.json', 'w');
fprintf(fid, '%s', jsonencode(results));
fclose(fid);
end

% Runs the actual benchmark code and returns execution times in microseconds:
function [t_scalar, t_matrix] = runbench(x, P)
N = 100;
tic;
for k=1:N
    res = sin(x(1));
    res = cos(x(1));
    res = x(1)^2;
    res = sqrt(x(1));
end
t_scalar = (1e6*toc)/N;
% Run matrix computations:
tic;
for k=1:N
    res = x'*P*x;
end
t_matrix = (1e6*toc)/N;
end

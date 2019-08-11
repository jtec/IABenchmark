function bench()
% Add CORA to path
addpath(genpath('cora'));
% Add fig2svg to path
addpath(genpath('fig2svg'));

% Intialize pseudo random number generator for repeatable results:
rng(31415);
% Run micro benchmark:

% Reals:
t_scalar_real = [];
t_matrix_real = [];
for k_run=1:10
    [t_scalar_real(k_run), t_matrix_real(k_run)] = runbench(rand(3,1), rand(3,3));
end
disp('Scalar operations on reals [탎]:');
scalar_real = interval(min(t_scalar_real), max(t_scalar_real))
disp('Matrix operations on reals [탎]:');
matrix_real = interval(min(t_matrix_real), max(t_matrix_real))

% Intervals:
t_scalar_int = [];
t_matrix_int = [];
res = 0;
for k_run=1:100
    x = rand(3,1) + rand(3,1) .* interval(-ones(3,1), ones(3,1));
    P = rand(3,3) + rand(3,3) .* interval(-ones(3,3), ones(3,3));
    [t_scalar_int(k_run), t_matrix_int(k_run)] = runbench(x, P);
end
disp('Scalar operations on intervals [탎]:');
scalar_int = interval(min(t_scalar_int), max(t_scalar_int))
disp('Matrix operations on intervals [탎]:');
matrix_int = interval(min(t_matrix_int), max(t_matrix_int))

hold off;
plot(t_scalar_int);
hold on;
plot(t_matrix_int);
ylabel('t [us]');
xlabel('Benchmark run');
legend({'Scalar operations', 'Matrix operations'});
fig2svg('matlabIntervalBenchmark.svg')
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

function bench()
% Add CORA to path
addpath(genpath('cora'));
% Intialize pseudo random number generator for repeatable results:
rng(31415);
% Run micro benchmark:

% Reals:
t_scalar = [];
t_matrix = [];
for k_run=1:10
    [t_scalar(k_run), t_matrix(k_run)] = runbench(rand(3,1), rand(3,3));
end
disp('Scalar operations on reals [탎]:');
scalar_real = interval(min(t_scalar), max(t_scalar))
disp('Matrix operations on reals [탎]:');
matrix_real = interval(min(t_matrix), max(t_matrix))

% Intervals:
t_scalar = [];
t_matrix = [];
res = 0;
for k_run=1:10
    [t_scalar(k_run), t_matrix(k_run)] = runbench(interval(rand(3,1)), interval(rand(3,3)));
end
disp('Interval operations on reals [탎]:');
scalar_int = interval(min(t_scalar), max(t_scalar))
disp('Interval operations on reals [탎]:');
matrix_int = interval(min(t_matrix), max(t_matrix))

scalar_int/scalar_real
end

% Runs the actual benchmark code and returns execution times in microseconds:
function [t_scalar, t_matrix] = runbench(x, P)
N = 1000;
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

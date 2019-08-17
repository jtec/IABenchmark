load('benchresults.mat');

disp('Scalar operations on intervals [�s]:');
scalar_int = interval(min(t_scalar_int), max(t_scalar_int))
disp('Matrix operations on intervals [�s]:');
matrix_int_min = min(t_matrix_int, [], 1);
matrix_int_max = max(t_matrix_int, [], 1);

figure(1);
hold off;
plot(t_scalar_int, 'o-');
ylabel('Execution time [us]');
xlabel('Benchmark run');
legend({'Scalar operations'});
title('CORA 2018')
yl = ylim();
ylim([0 yl(2)]);

figure(2);
hold off;
plot(ns, matrix_int_min, 'o-');
%hold on;
%plot(matrix_int_max, 'o-');
ylabel('Benchmark execution time [us]');
xlabel('Problem size');
%legend({'Min run time matrix operations', 'Max run time matrix operations'});
legend({'Min run time matrix operations'});
title('CORA 2018')
yl = ylim();
ylim([0 yl(2)]);

drawnow();
% Export
fig2svg('matlabIntervalBenchmarkScalar.svg', 1)
fig2svg('matlabIntervalBenchmarkMatrix.svg', 2)

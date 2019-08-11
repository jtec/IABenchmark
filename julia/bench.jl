using LinearAlgebra
using IntervalArithmetic
using BenchmarkTools
using Random
using Plots

cd(dirname(@__FILE__()))

# Runs the actual benchmark code and returns execution times in microseconds:
function runbench(x, P)
    texec = []
    N = 1000
    t0 = time_ns()
    for k in 1:N
        res = sin(x[1])
        res = cos(x[1])
        res = x[1]^2
        res = sqrt(x[1])
    end
    push!(texec, 1e-3*(time_ns()-t0)/N)
    # Run matrix computations:
    t0 = time_ns()
    for k in 1:N
        res = x'*P*x
    end
    push!(texec, 1e-3*(time_ns()-t0)/N)
end

# Intialize pseudo random number generator for repeatable results:
Random.seed!(31415);
# Run micro benchmark:

# Reals:
t_scalar = []
t_matrix = []
for k_run in 1:10
    texec = runbench(rand(3,1), rand(3,3))
    push!(t_scalar, texec[1])
    push!(t_matrix, texec[2])
end
print("Scalar operations on reals [µs]:")
println(Interval(minimum(t_scalar), maximum(t_scalar)))
print("Matrix operations on reals [µs]:");
println(Interval(minimum(t_matrix), maximum(t_matrix)))

# Intervals:
t_scalar = [];
t_matrix = [];
res = 0;
for k_run in 1:100
    x = rand(3,1) + rand(3,1) .* map(Interval, -ones(3,1), ones(3,1))
    P = rand(3,3) + rand(3,3) .* map(Interval, -ones(3,3), ones(3,3))
    texec = runbench(x, P)
    push!(t_scalar, texec[1])
    push!(t_matrix, texec[2])
end
print("Scalar operations on intervals [µs]:")  
println(Interval(minimum(t_scalar), maximum(t_scalar)))
print("Matrix operations on intervals [µs]:");
println(Interval(minimum(t_matrix), maximum(t_matrix)))

pgfplots()
plot(t_scalar, linewidth=2, label=["Scalar operations" "bof"])
plot!(t_matrix,linewidth=2, label=["Matrix operations" "bof"])
xlabel!("Run");
ylabel!("Execution time [µs]");

gui()
savefig("juliaIntervalBenchmark.svg")  
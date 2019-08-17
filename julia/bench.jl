using LinearAlgebra
using IntervalArithmetic
using BenchmarkTools
using Random
using Plots
using JLD2, FileIO

cd(dirname(@__FILE__()))

# Runs the actual benchmark code and returns execution times in microseconds:
function runbench(x, P)
    texec = []
    N = 100
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

# Intialize pseudo random number generator:
Random.seed!(31415);
# Run micro benchmark:

# Intervals:
t_scalar = [];
NN = 100;
let t_matrix = Array{Float64}(undef, NN, 0);
    ns = 2:10:200;
    for n in ns
        t_m = [];
        print("Running matrix operations for n = ")
        println(n)
        for k_run in 1:NN
            x = rand(n,1) + rand(n,1) .* map(Interval, -ones(n,1), ones(n,1))
            P = rand(n,n) + rand(n,n) .* map(Interval, -ones(n,n), ones(n,n))
            texec = runbench(x, P)
            push!(t_scalar, texec[1])
            push!(t_m, texec[2])
        end
        t_m = vec(t_m);
        t_matrix = hcat(t_matrix, t_m);
        println(size(t_matrix))
    end
    @save "results.jld2" t_scalar t_matrix ns
    println("Results saved to file")
end

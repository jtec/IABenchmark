using LinearAlgebra
using IntervalArithmetic
using BenchmarkTools
using Random
using Plots
using JLD2, FileIO

cd(dirname(@__FILE__()))
@load "results.jld2" t_scalar t_matrix

t_matrix_min = minimum(t_matrix, dims=1)

pgfplots()

p1 = plot(t_scalar, linewidth=2, label=["Scalar operations"], ylims=(0,Inf))
# plot!(t_matrix,linewidth=2, label=["Matrix operations" "bof"], ylims=(0,Inf))
xlabel!("Benchmark run");
ylabel!("Execution time [µs]");
title!("IntervalArithmetic.jl");

p2 = plot(t_matrix_min', linewidth=2, label=["Matrix operations"], ylims=(0,Inf))
# plot!(t_matrix,linewidth=2, label=["Matrix operations" "bof"], ylims=(0,Inf))
xlabel!("Problem size");
ylabel!("Execution time [µs]");
title!("IntervalArithmetic.jl");

gui()

savefig(p1, "juliaIntervalBenchmarkScalar.svg")
savefig(p2, "juliaIntervalBenchmarkMatrix.svg")
println("Plots saved.")

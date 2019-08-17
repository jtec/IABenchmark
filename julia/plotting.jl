using LinearAlgebra
using IntervalArithmetic
using BenchmarkTools
using Random
using Plots
using JLD2, FileIO
using JSON

cd(dirname(@__FILE__()))
# Load Julia results
@load "results.jld2" t_scalar t_matrix

# Load matlab results
mvars = JSON.parsefile("../matlab/benchresults.json")

t_matrix_min = minimum(t_matrix, dims=1)
t_matrix_min_matlab = minimum(mvars["t_matrix"], dims=1)
t_matrix_min_matlab = t_matrix_min_matlab[1]
ns = 2:10:200

pgfplots()

p1 = plot(t_scalar, linewidth=2, label=["IntervalArithmetic.jl"], ylims=(0,1500))
plot!(p1, mvars["t_scalar"], linewidth=2, label=["CORA 2018"])
# plot!(t_matrix,linewidth=2, label=["Matrix operations" "bof"], ylims=(0,Inf))
xlabel!("Benchmark run");
ylabel!("Execution time [µs]");
title!("Scalar operations");
gui()


p2 = plot(ns, t_matrix_min', linewidth=2, label=["IntervalArithmetic.jl"])
plot!(p2, ns, t_matrix_min_matlab, linewidth=2, label=["CORA 2018"], ylims=(0,Inf))
# plot!(t_matrix,linewidth=2, label=["Matrix operations" "bof"], ylims=(0,Inf))
xlabel!("Problem size");
ylabel!("Execution time [µs]");
title!("Matrix operations");
gui()

p3 = plot(ns, t_matrix_min_matlab ./ t_matrix_min', linewidth=2, label=["Cora 2018 / IntervalArithmetic.jl"], ylims=(0,Inf))
# plot!(t_matrix,linewidth=2, label=["Matrix operations" "bof"], ylims=(0,Inf))
xlabel!("Problem size");
ylabel!("Execution time ratio");
title!("Matrix operations - performance ratio");
gui()

p4 = plot(p2, p3, layout = 2)
gui()

savefig(p1, "intervalBenchmarkScalar.svg")
savefig(p2, "intervalBenchmarkMatrix.svg")
savefig(p3, "intervalBenchmarkMatrixRatios.svg")
savefig(p4, "intervalBenchmarkMatrixOverview.svg")

println("Plots saved.")

using LinearAlgebra

NN = 10
let t_matrix = Array{Float64}(undef, NN, 0)
    ns = 2:10:200
    for n in ns
        t_m = []
        print("Running matrix operations for n = ")
        println(n)
        for k_run in 1:NN
            texec = 3
            push!(t_m, 2)
        end
        t_m = vec(t_m)
        println(t_matrix)
        t_matrix = hcat(t_matrix, t_m);
        #println(size(t_matrix))
    end
end
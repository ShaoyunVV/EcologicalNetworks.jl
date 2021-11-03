"""
    count_loops(N::UnipartiteNetwork)

This function is counting the number of loops in a given network. Loops are trophic chains where a species is appearing more than one time.

"""
function count_loops(N::UnipartiteNetwork)

    d = maximum([round(Int, p.weight) for p in bellman_ford(N)])
    
    paths = Vector{Vector{EcologicalNetworks._species_type(N)}}()
    loops = Vector{Vector{EcologicalNetworks._species_type(N)}}()
    
    append!(paths, [[sp] for sp in species(N)])
    neighbors = Dict([sp => N[sp,:] for sp in species(N)])
    
    while !isempty(paths)
        initial_paths = copy(paths)
        done_paths = Vector{Vector{EcologicalNetworks._species_type(N)}}()
        new_paths = Vector{Vector{EcologicalNetworks._species_type(N)}}()
        for path in paths
            for n in neighbors[last(path)]
                if n in path
                    push!(loops, [path..., n])
                    for i in 1:length(path)
                        push!(done_paths, path[1:i])
                    end
                else
                    push!(new_paths, [path..., n])
                end
            end
        end
        unique!(done_paths)
        filter!(p -> length(p) >= d, paths)
        unique!(paths)
        if !isempty(new_paths)
            append!(paths, new_paths)
        end
        if !isempty(done_paths)
            deleteat!(paths, unique(sort(filter(!isnothing, indexin(done_paths, paths)))))
        end
        if paths == initial_paths
            break
        end
    end
    
    n_loops = length(unique(sort.(unique.(loops))))
    return n_loops
end

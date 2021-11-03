"""
This function is counting the number of species that interact with themselves in a given network.
"""
function cannibalism(N::UnipartiteNetwork)
    sum(N[s,s] for s in species(N))
end

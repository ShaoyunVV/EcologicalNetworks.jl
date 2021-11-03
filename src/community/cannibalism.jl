"""
    cannibalism(N::UnipartiteNetwork)

This function measure the number of species that practices cannibalism in a given network. A species is cannibal if she interacts with herself.
"""
function cannibalism(N::UnipartiteNetwork)
    sum(N[s,s] for s in species(N))
end

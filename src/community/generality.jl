"""
  generality(N::UnipartiteNetwork)

This function mesure the generality. The generality represents the link density (L/S) divided by the number of predators. The number of predators: (prop. of int + prop. of top)xS
"""
function generality(N::UnipartiteNetwork)
    out_degree = collect(values(degree(N; dims=1)))
    in_degree = collect(values(degree(N; dims=2)))
    degrees = DataFrame(out=out_degree, in=in_degree)
    B = nrow(degrees[degrees.out .== 0, :]) / nrow(degrees)
    T = nrow(degrees[degrees.in .== 0, :]) / nrow(degrees)
    I = nrow(degrees[(degrees.out .!= 0) .& (degrees.in .!= 0), :]) / nrow(degrees)
    L = links(N)
    Generality = L ./ (S.^2 .* (T .+ I))
    return Generality
end

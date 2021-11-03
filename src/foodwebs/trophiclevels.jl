function fractional_trophic_level(N::T) where {T<:UnipartiteNetwork}
  Y = nodiagonal(N)
  producers = keys(filter(spedeg -> spedeg.second == 0, degree(Y; dims=1)))
  sp = shortest_path(Y)
  prod_id = findall(isequal(0), vec(sum(sp; dims=2)))
  return Dict(zip(species(Y; dims=1), maximum(sp[:,prod_id]; dims=2).+1))
end
"""
  trophic_level(N::T) where {T<:UnipartiteNetwork}
  
The function is mesuring the trophic level for each species in a given unipartite network. The trophic level defines the place of the species in the network.
With a species trophic evel we can determined it's predators and preys. We can also predict it's function in the network.
  
"""
function trophic_level(N::T) where {T<:UnipartiteNetwork}
  TL = fractional_trophic_level(N)
  Y = nodiagonal(N)
  D = zeros(Float64, size(Y))
  ko = degree_out(Y)

  # inner loop to avoid dealing with primary producers
  for i in 1:richness(Y)
    if ko[species(Y)[i]] > 0.0
      D[i,:] = Y[i,:]./ko[species(Y)[i]]
    end
  end

  # return
  return Dict(zip(species(N), 1 .+ D * [TL[s] for s in species(Y)]))
end

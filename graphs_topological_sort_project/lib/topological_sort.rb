require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Khan's algorithm
# def topological_sort(vertices)
#   sorted = []

#   top = Array.new()
#   vertices.each do |vertex|
#     if vertex.in_edges.empty?
#       top.push(vertex)
#     end
#   end

#   until top.empty?
#     current = top.shift
#     sorted.push(current)

#     destinations = []

#     current.out_edges.count.times do
#       destinations << current.out_edges[0].to_vertex
#       current.out_edges[0].destroy!
#     end

#     destinations.each do |destination|
#       if destination.in_edges.empty?
#         top.push(destination)
#       end
#     end

#     vertices.delete(current)
#   end

#   vertices.empty? ? sorted : []
# end

# Tarjan's algorithm
require 'set'
def topological_sort(vertices)
  order = []
  explored = Set.new
  temp = Set.new
  cycle = false

  vertices.each do |vertex|
    cycle = dfs!(order, explored, vertex, temp, cycle) unless explored.include?(vertex)
    return [] if cycle
  end

  order
end

def dfs!(order, explored, vertex, temp, cycle)
  return true if temp.include?(vertex)
  temp.add(vertex)
  
  vertex.out_edges.each do |edge|
    to_vertex = edge.to_vertex
    cycle = dfs!(order, explored, to_vertex, temp, cycle) unless explored.include?(to_vertex)
    return true if cycle
  end

  explored.add(vertex)
  temp.delete(vertex)
  order.unshift(vertex)
  false
end
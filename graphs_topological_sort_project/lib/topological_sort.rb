require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Khan's algorithm
def topological_sort(vertices)
  sorted = []

  top = Array.new()
  vertices.each do |vertex|
    if vertex.in_edges.empty?
      top.push(vertex)
    end
  end

  until top.empty?
    current = top.shift
    sorted.push(current)

    destinations = []

    current.out_edges.count.times do
      destinations << current.out_edges[0].to_vertex
      current.out_edges[0].destroy!
    end

    destinations.each do |destination|
      if destination.in_edges.empty?
        top.push(destination)
      end
    end

    vertices.delete(current)
  end

  vertices.empty? ? sorted : []
end

# Tarjan's algorithm
# def toplogical_sort(vertices)

# end
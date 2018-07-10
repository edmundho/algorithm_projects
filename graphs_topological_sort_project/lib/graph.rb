class Vertex
  attr_accessor :in_edges, :out_edges
  attr_reader :value
  
  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
  end
end

class Edge
  attr_accessor :from_vertex, :to_vertex
  attr_reader :cost
  
  def initialize(from_vertex, to_vertex, cost = 1)
    @cost = cost
    @from_vertex = from_vertex
    @to_vertex = to_vertex

    @to_vertex.in_edges << self
    @from_vertex.out_edges << self
  end

  def destroy!
    from_vertex.out_edges.delete(self)
    to_vertex.in_edges.delete(self)
    self.from_vertex = nil
    self.to_vertex = nil
  end
end

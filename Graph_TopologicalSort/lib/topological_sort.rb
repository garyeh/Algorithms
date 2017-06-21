require_relative 'graph'

# Implementing topological sort using both Khan's and Tarjan's algorithms

# Kahn's Algorithm
def kahn_topological_sort(vertices)
  in_edge_count = {}
  zero_ins = []

  vertices.each do |vertex|
    in_edge_count[vertex] = vertex.in_edges.length
    zero_ins << vertex if vertex.in_edges.empty?
  end

  count = 0

  list = []
  until zero_ins.empty?
    u = zero_ins.shift
    list << u

    u.out_edges.each do |edge|
      to_vertex = edge.to_vertex
      in_edge_count[to_vertex] -= 1
      zero_ins << to_vertex if in_edge_count[to_vertex] == 0
    end

    count += 1
  end

  count == vertices.count ? list : []
end

# Tarjan's Algorithm
def topological_sort(vertices)
  order = []
  explored = Set.new
  temp = Set.new
  cycle = false

  vertices.each do |vertex|
    cycle = dfs!(vertex, explored, temp, order, cycle) unless explored.include?(vertex)
    return [] if cycle
  end

  order
end


def dfs!(vertex, explored, temp, order, cycle)
  return true if temp.include?(vertex)
  temp.add(vertex)

  vertex.out_edges.each do |edge|
    next_vertex = edge.to_vertex
    cycle = dfs!(next_vertex, explored, temp, order, cycle) unless explored.include?(next_vertex)
    return true if cycle
  end

  explored.add(vertex)
  temp.delete(vertex)
  order.unshift(vertex)
  false
end

require_relative 'graph'

# Implementing topological sort using both Khan's and Tarjan's algorithms

# Kahn's Algorithm
def topological_sort(vertices)
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
def tarjan_topological_sort(vertices)
  list = []
  count = []
  visited = Set.new

  vertices.each do |vertex|
    if !visited.include?(vertex)
      dfs_visit(vertex, visited, list, count)
    end
  end

  list
end

def dfs_visit(vertex, visited, list, count)
  visited << vertex

  vertex.out_edges.each do |edge|
    to_vertex = edge.to_vertex
    if !visited.include?(to_vertex)
      dfs_visit(to_vertex, visited, list, count)
    end
  end

  list.unshift(vertex)
end

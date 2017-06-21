# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'graph'
require_relative 'topological_sort'

def install_order(arr)
  values = (1..arr.flatten.max).to_a
  vertices = values.map { |val| Vertex.new(val) }

  # want dependency to be added to the package's in_edges
  # want package to be added to the dependency's out_edges
  arr.each do |tuple|
    package, dependency = vertices[tuple[0] - 1], vertices[tuple[1] - 1]
    Edge.new(dependency, package)
  end

  topological_sort(vertices).map(&:value)
end

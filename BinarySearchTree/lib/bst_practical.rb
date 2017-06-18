require_relative 'binary_search_tree'

def kth_largest(tree_node, k)
  reverse_traversal(tree_node, k)
end

def reverse_traversal(tree_node, k, max = [])
  reverse_traversal(tree_node.right, k, max) if tree_node.right
  max << tree_node
  reverse_traversal(tree_node.left, k, max) if tree_node.left

  max[k-1]
end

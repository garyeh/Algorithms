# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node'

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(value)
    if root
      deeper_insert(value, @root)
    else
      @root = BSTNode.new(value)
      value
    end
  end

  def find(value, tree_node = @root)
    return nil unless tree_node
    return tree_node if tree_node.value == value
    if value > tree_node.value
      find(value, tree_node.right)
    elsif value < tree_node.value
      find(value, tree_node.left)
    end
  end

  def delete(value)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  def deeper_insert(value, root)
    if value > root.value
      if root.right
        deeper_insert(value, root.right)
      else
        root.right = BSTNode.new(value)
        value
      end
    elsif value < root.value
      if root.left
        deeper_insert(value, root.left)
      else
        root.left = BSTNode.new(value)
        value
      end
    end
  end

end

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
    if value >= tree_node.value
      find(value, tree_node.right)
    elsif value < tree_node.value
      find(value, tree_node.left)
    end
  end

  def delete(value)
    target = find(value, @root)
    return nil unless target

    # Target has no children
    if !target.left && !target.right
      remove_child(target.parent, target)

    # Target has 2 children
    elsif target.left && target.right
      promoted = maximum(target.left)

      if target.parent.left == target
        target.parent.left = promoted
      elsif target.parent.right == target
        target.parent.right = promoted
      end

      # The recursive call that deletes the promoted's old location
      delete(promoted.value)
    # Target has 1 child
    elsif target.left || target.right
      promoted = get_single_child(target)

      if target.parent.left == target
        target.parent.left = promoted
      elsif target.parent.right == target
        target.parent.right = promoted
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    tree_node = tree_node.right while tree_node.right
    tree_node
  end

  def depth(tree_node = @root, counter = 0)
    return counter unless tree_node && (tree_node.left || tree_node.right)
    [depth(tree_node.left, counter + 1),
    depth(tree_node.right, counter + 1)].max
  end

  def is_balanced?(tree_node = @root)
    return false unless (depth(tree_node.left) - depth(tree_node.right)).abs <= 1
    [tree_node.left, tree_node.right].each do |node|
      next unless node
      return false unless is_balanced?(node)
    end
    true
  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr) if tree_node.right
    arr
  end


  private
  def deeper_insert(value, root, parent = nil)
    if value >= root.value
      if root.right
        deeper_insert(value, root.right, root)
      else
        root.right = BSTNode.new(value)
        root.right.parent = root
        value
      end
    elsif value < root.value
      if root.left
        deeper_insert(value, root.left, root)
      else
        root.left = BSTNode.new(value)
        root.left.parent = root
        value
      end
    end
  end

  def remove_child(parent, child)
    if child == @root
      @root = nil
    elsif parent.left == child
      parent.left = nil
    elsif parent.right == child
      parent.right = nil
    end
  end

  def get_single_child(node)
    node.left ? node.left : node.right
  end

end

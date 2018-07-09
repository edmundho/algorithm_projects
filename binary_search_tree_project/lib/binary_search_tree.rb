# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.
require_relative "bst_node"

class BinarySearchTree
  attr_accessor :root
  
  def initialize
    @root = nil
  end

  def insert(value, sub_root = @root)
    if @root.nil?
      @root = BSTNode.new(value)
    elsif value <= sub_root.value
      if sub_root.left.nil?
        sub_root.left = BSTNode.new(value)
        sub_root.left.parent = sub_root
      else
        insert(value, sub_root.left)
      end
    elsif value > sub_root.value
      if sub_root.right.nil?
        sub_root.right = BSTNode.new(value)
        sub_root.right.parent = sub_root
      else
        insert(value, sub_root.right)
      end
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    if value == tree_node.value
      return tree_node
    elsif value <= tree_node.value
      find(value, tree_node.left)
    elsif value > tree_node.value
      find(value, tree_node.right)
    end
  end

  def delete(value)
    found_node = find(value) || nil
    if value == @root.value
      @root = nil

    elsif found_node.left.nil? && found_node.right.nil?
      if found_node.parent.left == found_node
        found_node.parent.left = nil
      elsif found_node.parent.right == found_node
        found_node.parent.right = nil
      end

    elsif found_node.left && found_node.right
      max_child = maximum(found_node.left)
      if max_child.left
        max_child.parent.right = max_child.left
      end

      if found_node.parent.left == found_node
        found_node.parent.left = max_child
      elsif found_node.parent.right == found_node
        found_node.parent.right = max_child
      end

    elsif found_node.left || found_node.right
      if found_node.left
        if found_node.parent.left == found_node
          found_node.parent.left = found_node.left
        elsif found_node.parent.right == found_node
          found_node.parent.right = found_node.right
        end
      elsif found_node.right
        if found_node.parent.left == found_node
          found_node.parent.left = found_node.left
        elsif found_node.parent.right == found_node
          found_node.parent.right = found_node.right
        end
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    max = nil
    while tree_node.right
      max = tree_node.right
      tree_node = tree_node.right
    end
    max
  end

  def depth(tree_node = @root)
    return -1 unless tree_node
    left_depth = 1 + depth(tree_node.left)
    right_depth = 1 + depth(tree_node.right)

    left_depth > right_depth ? left_depth : right_depth
  end 

  def is_balanced?(tree_node = @root)
    depth_diff = depth(tree_node.left) - depth(tree_node.right)
    depth_diff *= -1 if depth_diff < 0
    return false if depth_diff > 1
    return true if tree_node.right.nil? || tree_node.left.nil?
    is_balanced?(tree_node.right)
    is_balanced?(tree_node.left)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr.push(tree_node.value)
    in_order_traversal(tree_node.right, arr) if tree_node.right
    arr
  end


  private
  # optional helper methods go here:

end

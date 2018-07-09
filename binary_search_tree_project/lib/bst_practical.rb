
def kth_largest(tree_node, k)
  result = in_order_traversal(tree_node)
  result[result.length - k]
end

def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr.push(tree_node)
    in_order_traversal(tree_node.right, arr) if tree_node.right
    arr
end

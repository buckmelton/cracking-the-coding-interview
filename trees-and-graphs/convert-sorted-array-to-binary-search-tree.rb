class BinaryNode

  @data
  @left
  @right

  attr_accessor :data, :left, :right

  def initialize(data)

    @data = data
    @left = nil
    @right = nil

  end

end

# Pseudocode:
#
# create_bst(sorted_arr)
#
# if array length == 0 return nil
# if array length == 1
#   return node with data
# if array length == 2
#   make nodes
#   make lesser node left child of greater node
#   return greater node
# if array length > 2
#   make node from middle element
#   left child = recurse(left half)
#   right child = recurse(right half)
#   return middle node

def create_bst(sorted_arr)

  return nil if sorted_arr.length == 0
  return BinaryNode.new(sorted_arr[0]) if sorted_arr.length == 1
  if sorted_arr.length == 2
    child = BinaryNode.new(sorted_arr[0])
    parent = BinaryNode.new(sorted_arr[1])
    parent.left = child
    return parent
  end

  middle = sorted_arr.length / 2
  left_start = 0
  left_end = (sorted_arr.length / 2) - 1
  right_start = left_end + 2
  right_end = sorted_arr.length

  cur_root = BinaryNode.new(sorted_arr[middle])
  cur_root.left = create_bst(sorted_arr[left_start..left_end])
  cur_root.right = create_bst(sorted_arr[right_start..right_end])

  return cur_root

end

def print_tree(root, level)
  return if root == nil

  level.times {print " "}
  puts root.data
  print_tree(root.left, level+2)
  print_tree(root.right, level+ 2)
end



arr = [10,15,22,25,32,89,600,2900,2901,2905,4000,5000,6500]
my_tree = create_bst(arr)
print_tree(my_tree, 0)

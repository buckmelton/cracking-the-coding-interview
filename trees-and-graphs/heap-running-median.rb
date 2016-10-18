# Keep track of the running median of a series of numbers.
# Best implemented using a min head and a max heap.
# This is because the running median will always be
#   1) the middle number if there are an odd number of numbers
#   2) the average of the two middle numbers if there are an even number of numbers
# If you maintain equally-sized min and max heaps, where the root of the max heap
#   always maintained smaller than the root of the min heap, then all numbers
#   in the max heap will be smaller than all numbers in the min heap.  This means
#   that
#   1) If there are an odd total number of numbers, one of the heaps will be one
#   larger than the other, and its root will be the median
#   2) If there are an even total number of number, then the average of the roots
#   will be the median
#
# But first, I want to do this with trees.

class BinaryNode

  @data
  @left
  @right

  attr_accessors :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

end

class MinHeap

  heap = BinaryNode.new

end

node = BinaryNode.new(5)
puts node.data
puts node.left
puts node.right

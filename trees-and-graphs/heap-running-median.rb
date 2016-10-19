# Keep track of and output the running median of a series of numbers.
# E.g if the numbers are 1,2,3,4,5 the running median is 1.0, 1.5, 2.0, 2.5, 3.0
#
# How to use:
# 1. Put your series of numbers into an array below:

nums = [12,4,5,3,8,7]

# 2. Run this file from the ruby interpreter.
# 3. The running median will be output to the console.

# Explanation:
#
# The median is the middle value of a set of values, such that the same number
# of values are less than the median as are greater.  So if the numbers are
# [1, 2, 6, 2000, 10000], the median is 6.
#
# If there an even number of values, the median is the average of the two
# middle values.  So if the numbers are
# [1, 2, 6, 2000, 10000, 10002], the median is 1003.

# The naive way would be to always draw from the middle index of an array of
# values that you keep sorted.  However, finding the insertion point and doing
# the insertion into the middle of an array becomes very costly when done
# over and over again.

# A better way is to use a min heap to store all the numbers greater than the
# median, and a max heap to store all the numbers smaller than the median.
# Insertion for a heap is O(log n), and extraction is O(1).  As long as you keep
# the heaps the same size, or only differing by 1, the median will always be
# the root of the larger heap, or the average of the roots if the heaps are the
# same size.

# To implement this I wrote the class MinHeap first and tested.  I began MaxHeap
# and realized much of the functionality was exactly the same, so I created
# the superclass Heap and subclassed MinHeap and MaxHeap from it.

class Heap

  @heap
  @size

  attr_accessor :heap, :size

  def initialize
    @heap = []
    @size = 0
  end

  def empty?
    return @size == 0
  end

  def swap(i, j)
    @heap[i], @heap[j] = @heap[j], @heap[i]
  end

  def get_parent_index(child_index)
    return (child_index - 1) / 2
  end

  def get_left_child_index(parent_index)
    return 2 * parent_index + 1
  end

  def get_right_child_index(parent_index)
    return 2 * parent_index + 2
  end

  def has_parent(index)
    return get_parent_index(index) >= 0
  end

  def has_left_child(index)
    return get_left_child_index(index) <= @size-1
  end

  def has_right_child(index)
    return get_right_child_index(index) <= @size-1
  end

  def left_child(parent_index)
    return @heap[get_left_child_index(parent_index)]
  end

  def right_child(parent_index)
    return @heap[get_right_child_index(parent_index)]
  end

  def parent(child_index)
    return @heap[get_parent_index(child_index)]
  end

  def peek
    return @heap[0]
  end

end

class MinHeap < Heap

  def fix_min_heap_up
    # the last element must be bubbled up until its parent is less than it
    index = @size-1

    while has_parent(index) && parent(index) > @heap[index]

      # swap
      swap(index, get_parent_index(index))

      # move pointers up
      index = get_parent_index(index)

    end
  end

  def fix_min_heap_down

    # the root element must be bubbled down until its children are greater than it
    index = 0

    while has_left_child(index)
      child_index = get_left_child_index(index)
      if has_right_child(index) && right_child(index) < left_child(index)
        child_index = get_right_child_index(index)
      end
      if @heap[child_index] < @heap[index]
        # swap
        swap(index, child_index)
      else
        break
      end

      index = child_index

    end
  end

  def insert(value)
    @heap[@size] = value
    @size += 1
    fix_min_heap_up
  end

  def extract
    if @size == 0
      raise Exception
    end
    min = @heap[0]
    @heap[0] = @heap[@size-1]
    @size -= 1
    fix_min_heap_down
    return min
  end

end

class MaxHeap < Heap

  def fix_max_heap_up
    # the last element must be bubbled up until its parent is more than it
    index = @size-1

    while has_parent(index) && parent(index) < @heap[index]

      # swap
      swap(index, get_parent_index(index))

      # move pointers up
      index = get_parent_index(index)

    end
  end

  def fix_max_heap_down

    # the root element must be bubbled down until its children are smaller than it
    index = 0

    while has_left_child(index)
      child_index = get_left_child_index(index)
      if has_right_child(index) && right_child(index) > left_child(index)
        child_index = get_right_child_index(index)
      end
      if @heap[child_index] > @heap[index]
        # swap
        swap(index, child_index)
      else
        break
      end

      index = child_index

    end
  end

  def insert(value)
    @heap[@size] = value
    @size += 1
    fix_max_heap_up
  end

  def extract
    if @size == 0
      raise Exception
    end
    max = @heap[0]
    @heap[0] = @heap[@size-1]
    @size -= 1
    fix_max_heap_down
    return max
  end

end


# Pseudocode
# Create a min heap and a max heap
# While there are more nums
#   Get new num
#   If both heaps empty, arbitrarily add to min heap
#   If num < max heap root, insert into max heap
#   If num > min heap root, insert into min heap
#   If num > max heap root && < min heap root
#     If the heaps are the same size, insert arbitrarily into min heap
#     Else insert into smaller heap
#   If the heap sizes differ by 2 or more, move from one root to the other heap
#     until sizes are the same or differ by 1
#   If sizes are the same, median is the average of the two roots
#   If sizes are off by one, median is root of the larger one

min_heap = MinHeap.new
max_heap = MaxHeap.new
nums.each do |num|

  # Figure out which heap to insert into
  if min_heap.empty? && max_heap.empty?
    min_heap.insert(num)
  elsif num > min_heap.peek
    min_heap.insert(num)
  elsif max_heap.empty? || num < max_heap.peek
    max_heap.insert(num)
  else  # num is between max heap root and min heap root
    if min_heap.size <= max_heap.size
      min_heap.insert(num)
    else
      max_heap.insert(num)
    end
  end

  # Even out the heap sizes (so that the roots always reflect median).
  if min_heap.size > max_heap.size
    l_heap = min_heap
    s_heap = max_heap
  else
    l_heap = max_heap
    s_heap = min_heap
  end
  while (min_heap.size - max_heap.size).abs > 1
    s_heap.insert(l_heap.extract)
  end

  # pull out the median
  if min_heap.size == max_heap.size
    median = (min_heap.peek + max_heap.peek) / 2
  elsif min_heap.size > max_heap.size
    median = min_heap.peek
  else
    median = max_heap.peek
  end

  puts median
end



# my_heap = MinHeap.new
# my_heap.insert(5)
# my_heap.insert(6)
# my_heap.insert(2)
# my_heap.insert(11)
# my_heap.insert(3)
# my_heap.insert(8)
# my_heap.insert(4)
# my_heap.insert(18)
# p my_heap.extract
# p my_heap.extract
# p my_heap.extract
# p my_heap.extract
# p my_heap.extract
# p my_heap.extract
# p my_heap.extract
# p my_heap.extract

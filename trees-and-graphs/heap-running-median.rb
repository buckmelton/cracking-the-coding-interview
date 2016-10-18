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
# At first, I wanted to do this with trees, for the exercise in the "intuitive"
#   way.  But then I discovered why the suggested implementation using arrays
#   is so much better: it's because you are constantly dealing with the "last"
#   item of the heap.  With trees, it's a hassle to keep track of the last node
#   and if you're adding a new last node, how to find where to put it.  With
#   arrays, the last element is always the last element of the array, and adding
#   a new last alement is as easy as appending to the end of the array.

class MinHeap

end

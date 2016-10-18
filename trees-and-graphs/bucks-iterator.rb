=begin
Given an array of arrays, implement an iterator class to allow the client to traverse and remove elements in the array list.  This iterator should provide three public class member functions:

boolean hasNext()
return true if there is another element in the set
int next()
return the value of the next element in the array
void remove()
remove the last element returned by the iterator.  That is, remove the element that the previous next() returned
This method can be called only once per call to next(), otherwise, an exception will be thrown. See http://docs.oracle.com/javase/8/docs/api/java/util/Iterator.html#remove() for details.

The code should be well structured, and robust enough to handle any access pattern.  Additionally, write code to demonstrate that the class can be used for the following basic scenarios:

Print elements
Given:  [[],[1,2,3],[4,5],[],[],[6],[7,8],[],[9],[10],[]]
Print:  1 2 3 4 5 6 7 8 9 10

 Remove even elements
Given:  [[],[1,2,3],[4,5],[],[],[6],[7,8],[],[9],[10],[]]
Should result in:  [[],[1,3],[5],[],[],[],[7],[],[9],[],[]]
Print:  1 3 5 7 9
=end

=begin
it = MyIterator.new([[],[1,2,3],[4,5],[],[],[6],[7,8],[],[9],[10],[]])
while it.hasNext()
  print it.next()
end
=end


# 1 2 3 4 5 6 7 8 9 10


class MyIterator

  @input
  @inner_cursor
  @outer_cursor
  @prev_outer
  @prev_inner

  attr_accessor :input, :inner_cursor, :outer_cursor

  def  initialize(input)
    @input = input
    @inner_cursor = 0
    @outer_cursor = 0
  end

  def has_next?

    # Pseudocode
    # If inner_cursor is before the last element of its inner array OR
    #  there are more inner arrays AND one of them has something in it

    if @inner_cursor < @input[@outer_cursor].length ||
      @outer_cursor < @input.length - 1 && @input[@outer_cursor+1..@input.length-1].find {|inner| inner.length > 0}
      return true
    end
    return false
  end

  def next

    # Special case: at the beginning, the cursors may not be pointing
    # to the first element.
    if @outer_cursor == 0 && @inner_cursor == 0
      while @input[@outer_cursor].length == 0
        @outer_cursor += 1
      end
    end

    element = @input[@outer_cursor][@inner_cursor]

    # Save cursors in case of "remove" call
    @prev_outer = @outer_cursor
    @prev_inner = @inner_cursor

    # Advance cursor to next element
    if @inner_cursor == @input[@outer_cursor].length - 1
      @inner_cursor = 0
      @outer_cursor += 1
      while @outer_cursor < @input.length - 1 && @input[@outer_cursor].length == 0
        @outer_cursor += 1
      end
    else
      @inner_cursor += 1
    end

    return element

  end

  def remove
    # if the inner cursor isn't on the first element of the inner array, we have to
    # move it back
    if @inner_cursor != 0
      @inner_cursor -= 1
    end
    @input[@prev_outer].delete_at(@prev_inner)
  end

  def print_elements
    @input.each do |outer|
      outer.each do |inner|
        print inner.to_s + " "
      end
    end
    puts
  end

end

my_iterator = MyIterator.new([[],[1,2,3],[4,5],[],[],[6],[7,8],[],[9],[10],[]])


while my_iterator.has_next?
  puts my_iterator.next
end

puts
my_iterator.print_elements
puts

remove_iterator = MyIterator.new([[],[1,2,3],[4,5],[],[],[6],[7,8],[],[9],[10],[]])
while remove_iterator.has_next?
  element = remove_iterator.next
  if element.even?
    remove_iterator.remove
  end
end
puts remove_iterator.input

puts
remove_iterator.print_elements

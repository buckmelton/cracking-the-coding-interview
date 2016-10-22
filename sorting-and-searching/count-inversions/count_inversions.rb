# This was my second attempt.  For both my first and this attempt, I think I was not correctly
# returning the modified merged sorted array.

# I figured it out!!  I was correct, I wasn't modifying the merged sorted array on the way out.  This solution uses
# indices directly into the full array to create slices for the increasingly smaller portions of the full array.  So
# what I had to make sure to do was, at the end of the #merge method, transfer the working array to the correct
# sub-slice of the full master array.  YEE-HAW!!

class CountInversions

  def count_inversions(arr)
      # To count the inversions, just do a merge sort but add sugar to it to count inversions along the way.
      merge_sort(arr, 0, arr.length-1)
  end

  def merge_sort(arr, first, last)
      # if we've recursed down to nothing, just return
      if first == last
          return 0
      end

      # find the midpoint of array
      mid = (first + last) / 2

      count = 0
      # count inversions in the left array and right array
      count += merge_sort(arr, first, mid)
      count += merge_sort(arr, mid+1, last)

      # count the "split" inversions, i.e. inversions that result from having to move an element from the right array
      # over elements of the left array.
      count += merge(arr, first, last)

      return count
  end

  def merge(arr, first, last)

      # This is the temp array that we'll be transferring values from the left and right arrays to as
      # we merge them.
      working_arr = Array.new(last-first+1)
      curr = 0    # where we're at in filling up the merged working array

      # remember, we're using a master array, and first and last are just defining the slice of the master
      # array that we're working with at this recursion level.   Find the midpoint - the separation point between
      # the left and right arrays we're working with at this recursion level
      mid = (first + last) / 2
      i = first
      j = mid+1
      count = 0

      # work through the left array and right array.  If the element in the left array is next, there is no inversion.
      # But if the element in the right array is next, the number of inversions is the number of elements in the left
      # array that the right element is jumping over.  This is indicated by the difference between the cursor into
      # the left array and the end of the left array (the midpoint).
      while (i<=mid && j<=last)
          if arr[i] > arr[j]
              working_arr[curr] = arr[j]
              j += 1
              count += mid - i + 1
          else
              working_arr[curr] = arr[i]
              i += 1
          end
          curr +=1
      end

      # We reached the end of either the left or right arrays, so we just fill in the rest of the working
      # array with whichever of the two still has elements.
      while i<=mid
          working_arr[curr] = arr[i]
          i += 1
          curr += 1
      end
      while j<=last
          working_arr[curr] = arr[j]
          j += 1
          curr += 1
      end

      # This was the key!  Copy the working array (which due to recursion is only a slice of the original array)
      # back to THE APPROPRIATE POSITION in the original array, so that that portion of the master array is now
      # sorted.
      arr[first..last] = working_arr[0..working_arr.length-1]

      return count

  end

end

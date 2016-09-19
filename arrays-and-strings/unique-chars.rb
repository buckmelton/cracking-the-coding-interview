
# First try:
# Turn string into array
# Sort array
# Compare each letter to the one after it
# If they're equal, false
# If you don't find any equal chars, the chars are unique

# def unique_chars?(the_str)
#   sorted_ary = the_str.split("").sort
#   for i in 0..sorted_ary.length-2
#     if sorted_ary[i] == sorted_ary[i+1]
#       return false
#     end
#   end
#   return true
# end

# Second try
# Convert string to array
# If array and array.uniq have same length, return true
# Otherwise return false

# def unique_chars?(the_str)
#   the_ary = the_str.split('')
#   return the_ary.length == the_ary.uniq.length
# end

# Third try
# Convert string to hash
# If string and hash have same length, return true
# Otherwise, return false

def unique_chars?(the_str)
  the_hash = {}
  the_str.split('').each {|char| the_hash[char] = ''}
  return the_str.length == the_hash.length
end


puts unique_chars?('Ronald')
puts unique_chars?('RonaldR')
puts unique_chars?('Buck')
puts unique_chars?('Buck bo')
puts unique_chars?('Buck Bo')

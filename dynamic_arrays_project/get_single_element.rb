
def get_single_element(sorted_array)
  # return sorted_array[0] if sorted_array.length == 1
  
  middle = sorted_array.length / 2

  if sorted_array[middle] == sorted_array[middle + 1]
    array_to_check = sorted_array.drop(middle)
  elsif sorted_array[middle] == sorted_array[middle - 1]
    array_to_check = sorted_array.take(middle + 1)
  end

  
  
end


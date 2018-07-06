class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    pivot_idx = rand(array.length)

    left = []
    right = []

    array.each do |el|
      left << el if el < array[pivot_idx]
      right << el if el >= array[pivot_idx]
    end

    sort1(left) + array[pivot_idx] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    return array if length <= 1

    pivot_idx = partition(array, start, length, &prc)

    left_length = pivot_idx - start
    right_length = length - (left_length + 1)

    sort2!(array, start, left_length, &prc)
    sort2!(array, pivot_idx + 1, right_length, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }


    pivot_idx = start
    pivot_value = array[pivot_idx]

    ((start + 1)...(start + length)).each do |current_idx|
      current_value = array[current_idx]

      if prc.call(current_value, pivot_value) < 0
        pivot_idx += 1
        array[current_idx], array[pivot_idx] = array[pivot_idx], array[current_idx]
      end

    end

    array[start], array[pivot_idx] = array[pivot_idx], array[start]

    pivot_idx
  end
end
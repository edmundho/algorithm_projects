require_relative "heap"

class Array
  def heap_sort!

    i = 1
    while i < length
      BinaryMinHeap.heapify_up(self, i)

      i += 1
    end

    # heap = BinaryMinHeap.new
    # length.times { heap.push(self.shift) }
    # # p heap

    # j = heap.store.length
    # while j > 0
    #   self.push(heap.extract)

    #   j -= 1
    # end

    j = length - 1
    while j > 0
      self[0], self[j] = self[j], self[0]
      BinaryMinHeap.heapify_down(self, 0, j)

      # p self
      j -= 1
    end

    self.reverse!
  end
end

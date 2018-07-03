require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    raise Exception.new('index out of bounds') if @store[index].nil?
    @store[(index + @start_idx) % @capacity]
  end

  # O(1)
  def []=(index, val)
    @store[(index + @start_idx) % @capacity] = val
  end

  # O(1)
  def pop
    raise Exception.new('index out of bounds') if @length < 1

    popped_value = @store[@length - 1]
    @length -= 1
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  # O(1)
  def shift
    raise Exception.new('index out of bounds') if @length < 1

    shifted_val, self[0] = self[0], nil
    start_idx = (start_idx + 1) % capacity

    @length -= 1
    return shifted_val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity

    self.length += 1
    self.start_idx = (self.start_idx - 1) % capacity
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    # new_array = StaticArray.new(@length * 2)
    # idx = @start_idx + @capacity
    # count = 0
    # until count == @length
    #   new_array[idx % (@capacity * 2)] = @store[(idx - @capacity) % @capacity]
    #   idx += 1
    #   count += 1
    # end
    # @store = new_array
    # @start_idx = @start_idx + @capacity
    # @capacity = @capacity * 2
    old_store = @store
    @store = StaticArray.new(@capacity * 2)
    @capacity *= 2
    i = 0
    while old_store[i]
      @store[i] = old_store[i]
      i += 1
    end
  end
end

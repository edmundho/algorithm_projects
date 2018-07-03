require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new
    @length = 0
  end

  # O(1)
  def [](index)
    if @store[index].nil? 
      raise Exception.new('index out of bounds')
    else
      @store[index]
    end
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    if @length > 0
      popped_value = @store[@length - 1]
      @length -= 1
      return popped_value
    else
      raise Exception.new('index out of bounds')
    end
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
    return store
  end

  # O(n): has to shift over all the elements.
  def shift
    raise Exception.new('index out of bounds') if @length < 1

    shifted_val = @store[0]

    i = 0
    while @store[i]
      @store[i] = @store[i + 1]
      i += 1
    end

    @length -= 1
    return shifted_val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity

    i = @length
    while i > 0
      @store[i] = @store[i - 1]
  
      i -= 1
    end
    @length += 1
    @store[0] = val
    return store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    !!@store[index]
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
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

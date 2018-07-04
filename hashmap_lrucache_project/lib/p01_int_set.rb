class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    raise Exception.new('Out of bounds') if num > max || num < 0
    @store[num] = true if num <= max && !self.include?(num)
  end

  def remove(num)
    @store[num] = false if self.include?(num)
  end

  def include?(num)
    !!@store[num]
  end

  private
  attr_reader :max

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num].push(num)
  end

  def remove(num)
    self[num].shift
  end

  def include?(num)
    !!self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    self[num].push(num)
    @count += 1
  end

  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num][0] == num
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }

    i = 0
    while i < @store.length

      j = 0
      while j < @store[i].length
        to_be_rehashed = @store[i][j]
        new_store[to_be_rehashed % new_store.length].push(to_be_rehashed)
        
        j += 1
      end
      i += 1
    end

    @store = new_store
  end
end

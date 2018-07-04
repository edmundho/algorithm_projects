require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    self[key].push(key)
    @count += 1
  end

  def include?(key)
    !!self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
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
        rehash = @store[i][j]
        new_store[rehash.hash % new_store.length].push(rehash)
        
        j += 1
      end
      i += 1
    end
    @store = new_store
  end
end

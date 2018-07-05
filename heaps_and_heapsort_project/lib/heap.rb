require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize # = Thursday, July 5 | 09:29Proc.new { |x, y| x <=> y })
    @store = []
    # @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    extracted_el = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, @store.length)
    return extracted_el
  end

  def peek
    @store.first
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, @store.length - 1) if @store.length > 1
  end

  public
  def self.child_indices(len, parent_index)
    child_indices = []
    left_child = 2 * parent_index + 1
    right_child = 2 * parent_index + 2
    child_indices << left_child if left_child < len
    child_indices << right_child if right_child < len
    child_indices
  end

  def self.parent_index(child_index)
    raise Exception.new("root has no parent") if child_index.zero?
    parent_index = (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    child_indices = self.child_indices(len, parent_idx)
    children = []
    child_indices.each { |i| children << array[i] }

    if prc.nil? 
      prc = Proc.new { |x, y| x <=> y }
      while children.length > 0 && children.any? { |child| prc.call(array[parent_idx], child) == 1 }
        smaller_child_idx = array.index(children.min)
        array[parent_idx], array[smaller_child_idx] = array[smaller_child_idx], array[parent_idx]

        parent_idx = smaller_child_idx
        child_indices = self.child_indices(len, parent_idx)
        children = []
        child_indices.each { |i| children << array[i] }
      end
    else
      while children.length > 0 && children.any? { |child| prc.call(array[parent_idx], child) == 1 }
        larger_child_idx = array.index(children.max)
        array[parent_idx], array[larger_child_idx] = array[larger_child_idx], array[parent_idx]

        parent_idx = larger_child_idx
        child_indices = self.child_indices(len, parent_idx)
        children = []
        child_indices.each { |i| children << array[i] }
      end
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    parent_idx = self.parent_index(child_idx)
    prc ||= Proc.new { |x, y| x <=> y }

    while prc.call(array[child_idx], array[parent_idx]) == -1
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      child_idx = parent_idx
      parent_idx = self.parent_index(child_idx) unless child_idx.zero?
    end
    
    array
  end
end

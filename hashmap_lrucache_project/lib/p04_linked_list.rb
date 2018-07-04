
class Node
  attr_accessor :key, :val, :next, :prev
  
  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end
  
  def to_s
    "#{@key}: #{@val}"
  end
  
  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail || @tail.prev == @head
  end

  def get(key)
    current_node = @head
    while current_node.next
      if current_node.key == key
        return current_node.val
      end
      current_node = current_node.next
    end
    nil
  end

  def include?(key)
    # current_node = @head
    # while current_node
    #   if current_node.key == key
    #     return true
    #   end
    #   current_node = current_node.next
    # end
    # false
    self.any? { |node| node.key == key }
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = self.last
    new_node.next = @tail

    @tail.prev.next = new_node
    @tail.prev = new_node
  end

  def update(key, val)
    current_node = @head
    while current_node.next
      if current_node.key == key
        current_node.val = val
        break
      end
      current_node = current_node.next
    end
  end

  def remove(key)
    current_node = @head
    while current_node.next
      if current_node.key == key
        current_node.remove
        break
      end
      current_node = current_node.next
    end
  end

  def each
    current_node = self.first
    while current_node.next
      yield(current_node)
      current_node = current_node.next
    end
    return self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end

class BSTNode
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @parent = nil
  end

  attr_accessor :left, :right, :parent
  attr_reader :value
end

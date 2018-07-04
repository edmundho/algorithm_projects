class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_this = self.map do |element|
      if element.is_a? Array
        element.concat(['s'])
      else
        element
      end
    end
    hash_this.join.split("").map { |ch| ch.ord }.join.to_i.hash
  end
end

class String
  def hash
    self.split("").hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    keys = self.keys.sort.join.split("")
    vals = self.values.sort.join.split("")
    (keys + vals).hash
  end
end

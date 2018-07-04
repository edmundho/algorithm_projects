require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
  counter = Hash.new(0)

  string.split("").each { |letter| counter[letter] += 1 }

  counter.values.count { |el| el.odd? } <= 1
end

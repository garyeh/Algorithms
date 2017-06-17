require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  lookup = HashMap.new
  count = 0
  string.each_char do |char|
    lookup[char] = lookup[char] ? (lookup[char] + 1) % 2 : 1
  end

  lookup.each { |key, val| count += 1 if val == 1 }
  count <= 1
end

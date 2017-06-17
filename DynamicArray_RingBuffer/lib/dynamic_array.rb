require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if @store[index] == nil
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    if @length == 0
      raise "index out of bounds"
    else
      popped, @store[@length - 1] = @store[@length - 1], nil
      @length -= 1
      popped
    end
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    check_index(@length)
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length == 0
      raise "index out of bounds"
    else
      idx = 0
      val = @store[idx]
      while idx < @length
        @store[idx] = @store[idx + 1]
        idx += 1
      end
      @length -= 1
      val
    end
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    check_index(@length)
    idx = @length
    while idx > 0
      @store[idx] = @store[idx - 1]
      idx -= 1
    end
    @store[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    if index == @capacity
      resize!
    end
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)

    idx = 0
    while idx < @length
      new_store[idx] = @store[idx]
      idx += 1
    end
    @store = new_store
  end
end

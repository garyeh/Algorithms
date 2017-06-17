require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @start_idx = 0
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if @store[(@start_idx + index) % @capacity] == nil
    @store[(@start_idx + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    @store[@start_idx + index] = val
  end

  # O(1)
  def pop
    if @length == 0
      raise "index out of bounds"
    else
      popped = self[@length - 1]
      self[@length - 1] = nil
      @length -= 1
      popped
    end
  end

  # O(1) ammortized
  def push(val)
    check_index(@length)
    @store[(@start_idx + @length) % @capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    if @length == 0
      raise "index out of bounds"
    else
      shifted = @store[@start_idx]
      @store[@start_idx] = nil
      @start_idx = (@start_idx + 1) % @capacity
      @length -= 1
      shifted
    end
  end

  # O(1) ammortized
  def unshift(val)
    check_index(@length)
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    if index == @capacity
      resize!
    end
  end

  def resize!
    new_store = StaticArray.new(@capacity * 2)

    idx = 0
    while idx < @length
      new_store[idx] = self[idx]
      idx += 1
    end
    @start_idx = 0
    @store = new_store
    @capacity = @capacity * 2
  end
end

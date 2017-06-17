require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new
    length.times { |idx| heap.push(self[idx]) }
    length.times { |idx| self[idx] = heap.extract }
    self
  end
end

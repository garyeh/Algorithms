require_relative 'heap'

def k_largest_elements(array, k)
  max_prc = Proc.new { |a, b| b <=> a }
  result = []
  heap = BinaryMinHeap.new(&max_prc)
  array.count.times { |idx| heap.push(array[idx]) }
  k.times { result << heap.extract }
  result
end

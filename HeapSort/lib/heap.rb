class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc || Proc.new { |a, b| a <=> b }
    @store = []
  end

  def count
    @store.count
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    extracted = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count, &@prc)
    extracted
  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, count, &@prc)
    val
  end

  public
  def self.child_indices(len, parent_index)
    child_1_index = (2 * parent_index + 1) < len ? [2 * parent_index + 1] : []
    child_2_index = (2 * parent_index + 2) < len ? [2 * parent_index + 2] : []
    child_1_index + child_2_index
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    child_indices = BinaryMinHeap.child_indices(len, parent_idx)
    until child_indices.none? { |child_idx| prc.call(array[parent_idx], array[child_idx]) == 1 }
      child_indices.each do |child_idx|
        if prc.call(array[parent_idx], array[child_idx]) == 1
          child = child_idx
          if child_indices.length == 2
            child = (prc.call(array[child_indices[0]], array[child_indices[1]]) == 1 ?
            child_indices[1] : child_indices[0])
          end
          array[parent_idx], array[child] = array[child], array[parent_idx]
          parent_idx = child
          child_indices = BinaryMinHeap.child_indices(len, parent_idx)
          break
        end
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    parent_index = child_idx == 0 ? child_idx : BinaryMinHeap.parent_index(child_idx)
    until prc.call(array[parent_index], array[child_idx]) != 1
      array[parent_index], array[child_idx] = array[child_idx], array[parent_index]
      child_idx = parent_index
      break if child_idx == 0
      parent_index = BinaryMinHeap.parent_index(child_idx)
    end
    array
  end
end

# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @max_history = RingBuffer.new
  end

  def enqueue(val)
    @store.push(val)
    if @max_history.length == 0 || val > @max_history[@max_history.length - 1]
      @max_history.push(val)
    else
      @max_history.push(@max_history[@max_history.length - 1])
    end
  end

  def dequeue
    if @store.shift == @max_history.shift
      new_history = RingBuffer.new
      idx = 0
      while idx < @store.length
        if new_history.length == 0 || @store[idx] > new_history[new_history.length - 1]
          new_history.push(@store[idx])
        else
          new_history.push(new_history[new_history.length - 1])
        end
        idx += 1
      end
    end
    @max_history = new_history
  end

  def max
    @max_history[@max_history.length - 1]
  end

  def length
    @store.length
  end

end

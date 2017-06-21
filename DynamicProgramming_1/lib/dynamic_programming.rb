class DynamicProgramming
  def initialize
    @blair_cache = { 1 => 1, 2 => 2}
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]

    num = blair_nums(n-1) + blair_nums(n-2) + n * 2 - 1
    @blair_cache[n] = num
  end

  def frog_hops(n)
    cache = frog_cache_builder(n)

    cache[n]
  end

  def frog_cache_builder(n)
    frog_cache = { 1 => [[1]],
                   2 => [[1, 1], [2]],
                   3 => [[1, 1, 1], [1, 2], [2, 1], [3]] }
    return frog_cache if n < 4
    (4..n).each do |i|
      
    end

    frog_cache
  end

  def frog_hops_top_down(n)
  end

  def super_frog_hops(n, k)
  end

  def make_change(amt, coins)
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end

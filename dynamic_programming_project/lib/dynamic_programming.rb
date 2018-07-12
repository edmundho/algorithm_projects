class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = []
  end

  def blair_nums(n)
    return @blair_cache[n] unless @blair_cache[n].nil?

    ans = blair_nums(n - 2) + blair_nums(n - 1) + ((n - 1) * 2 - 1)
    @blair_cache[n] = ans
    return ans
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)

    cache[n]
  end

  def frog_cache_builder(n)
    cache = { 
      1 => [[1]], 
      2 => [[1, 1], [2]], 
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]] 
    }
    return cache if n < 4

    (4..n).each do |i|
      arr1 = cache[i - 1].map { |solution| solution + [1] }
      arr2 = cache[i - 2].map { |solution| solution + [2] }
      arr3 = cache[i - 3].map { |solution| solution + [3] }
      cache[i] = arr1 + arr2 + arr3
    end

    cache
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]
    new_way_set = []

    (1..3).each do |first_step|
      frog_hops_top_down_helper(n - first_step).each do |way|
        new_way = [first_step]

        way.each do |step|
          new_way << step
        end

        new_way_set << new_way
      end
    end

    @frog_cache[n] = new_way_set
  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    table = {}

    (1..capacity).each do |cap|
      weights.each_with_index do |weight, i|
        table[cap] = []
        if weight < cap
          remaining_cap = cap - weight
          table[cap] << weight
        else

        end
      end
    end
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end

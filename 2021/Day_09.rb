### Input ###

map = File.read("./Input/Day_09_Input.txt").chomp.split("\n").map { |map| map.split("") }

map = map.map do |layer|
  layer.map do |height|
    height.to_i
  end
end

### Methods ###

def display(map)
  map.each do |layer|
    p layer
  end
end

### Part 1 ###

low_point_map = Array.new(map.size, 0)
low_point_map.map! { |low_point_map_layer| Array.new(map[0].size, 0) }

BOTTOM_BOUND = map.size - 1
RIGHT_BOUND = map[0].size - 1

map.each_with_index do |layer, layer_n|
  layer.each_with_index do |height, index|
    low_point = true
    
    if index - 1 >= 0  # compare with the height on the left
      if height >= map[layer_n][index - 1]
        low_point = false
        next
      end
    end
    if index + 1 <= RIGHT_BOUND  # compare with the height on the right
      if height >= map[layer_n][index + 1]
        low_point = false
        next
      end
    end
    if layer_n - 1 >= 0  # compare with the height on top on it
      if height >= map[layer_n - 1][index]
        low_point = false
        next
      end
    end
    if layer_n + 1 <= BOTTOM_BOUND  # compare with the height underneath it
      if height >= map[layer_n + 1][index]
        low_point = false
        next
      end
    end

    low_point_map[layer_n][index] = 1 if low_point
  end
end

answer = 0
map.each_with_index do |layer, layer_n|
  layer.each_with_index do |height, index|
    answer += height + 1 if low_point_map[layer_n][index] == 1
  end
end

p answer

### Part 2 ###

# Approach: Do depth-first search from each low point

basin_map = Array.new(map.size, 0)
basin_map.map! { |basin_map_layer| Array.new(map[0].size, 0) }

visited_map = Array.new(map.size, 0)
visited_map.map! { |basin_map_layer| Array.new(map[0].size, 0) }

def dfs(dfs_stack, layer_n, index, map, visited_map, basin_map, basin_no)
  visited_map[layer_n][index] = 1
  dfs_stack << [layer_n, index]

  basin_map[layer_n][index] = basin_no  
  
  # go to the point on the left
  if index - 1 >= 0 && map[layer_n][index - 1] != 9 && visited_map[layer_n][index - 1] == 0
    dfs(dfs_stack, layer_n, index - 1, map, visited_map, basin_map, basin_no)
  else
    dfs_stack.pop
  end
  
  # go to the point on the right
  if index + 1 <= RIGHT_BOUND && map[layer_n][index + 1] != 9 && visited_map[layer_n][index + 1] == 0
    dfs(dfs_stack, layer_n, index + 1, map, visited_map, basin_map, basin_no)
  else
    dfs_stack.pop
  end
  
  # go to the point on top of it
  if layer_n - 1 >= 0 && map[layer_n - 1][index] != 9 && visited_map[layer_n - 1][index] == 0
    dfs(dfs_stack, layer_n - 1, index, map, visited_map, basin_map, basin_no)
  else
    dfs_stack.pop
  end
  
  # go to the point underneath it
  if layer_n + 1 <= BOTTOM_BOUND && map[layer_n + 1][index] != 9 && visited_map[layer_n + 1][index] == 0
    dfs(dfs_stack, layer_n + 1, index, map, visited_map, basin_map, basin_no)
  else
    dfs_stack.pop
  end
end

basin_no = 0
map.each_with_index do |layer, layer_n|
  layer.each_with_index do |height, index|
    if low_point_map[layer_n][index] == 1
      basin_no += 1
      dfs_stack = []  # depth-first search
      dfs(dfs_stack, layer_n, index, map, visited_map, basin_map, basin_no)
    end
  end
end

count_hash = Hash.new(0)
basin_map.flatten.each do |basin_no|
  count_hash[basin_no] += 1 if basin_no != 0
end

count = count_hash.values.sort

answer = count[-1] * count[-2] * count[-3]
p answer

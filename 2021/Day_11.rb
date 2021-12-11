### Methods ###

def display(map)
  map.each do |layer|
    p layer
  end
end

def energy_up(map, layer_n, index)
  if index - 1 >= 0  # left
    map[layer_n][index - 1] += 1
    map[layer_n - 1][index - 1] += 1 if layer_n - 1 >= 0  # top-left
    map[layer_n + 1][index - 1] += 1 if layer_n + 1 <= BOTTOM_BOUND  # bottom-left
  end
  if index + 1 <= RIGHT_BOUND  # right
    map[layer_n][index + 1] += 1
    map[layer_n - 1][index + 1] += 1 if layer_n - 1 >= 0  # top-right
    map[layer_n + 1][index + 1] += 1 if layer_n + 1 <= BOTTOM_BOUND  # bottom-right
  end
  if layer_n - 1 >= 0  # top
    map[layer_n - 1][index] += 1
  end
  if layer_n + 1 <= BOTTOM_BOUND  # bottom
    map[layer_n + 1][index] += 1
  end
end

### Part 1 ###

map = File.read("./Input/Day_11_Input.txt").chomp.split("\n").map { |map| map.split("") }

map = map.map do |layer|
  layer.map do |energy|
    energy.to_i
  end
end

BOTTOM_BOUND = map.size - 1
RIGHT_BOUND = map[0].size - 1

flash_count = 0

100.times do
  map.map! do |layer|
    layer.map! do |energy|
      energy += 1
    end
  end
  
  increased = Array.new(map.size, 0)
  increased.map! { |_| Array.new(map[0].size, 0) }
  
  map.each_with_index do |layer, layer_n|
    layer.each_with_index do |energy, index|
      if energy > 9 && increased[layer_n][index] == 0
        energy_up(map, layer_n, index)
        increased[layer_n][index] = 1
      end
    end
  end
  
  keep_looping = Array.new(map.size, 0)
  keep_looping.map! { |_| Array.new(map[0].size, true) }
  
  while keep_looping.flatten.any?(true)
    map.each_with_index do |layer, layer_n|
      layer.each_with_index do |energy, index|
        if energy > 9 && increased[layer_n][index] == 0
          energy_up(map, layer_n, index)
          increased[layer_n][index] = 1
        end
      end
    end
    
    map.each_with_index do |layer, layer_n|
      layer.each_with_index do |energy, index|
        if energy > 9 && increased[layer_n][index] == 0
          keep_looping[layer_n][index] = true
        else
          keep_looping[layer_n][index] = false
        end
      end
    end
  end
  
  map.each_with_index do |layer, layer_n|
    layer.each_with_index do |energy, index|
      if energy > 9
        map[layer_n][index] = 0
        flash_count += 1
      end
    end
  end
end

p flash_count

### Part 2 ###

map = File.read("./Input/Day_11_Input.txt").chomp.split("\n").map { |map| map.split("") }

map = map.map do |layer|
  layer.map do |energy|
    energy.to_i
  end
end

step_count = 0

until map.flatten.all?(0)
  step_count += 1

  map.map! do |layer|
    layer.map! do |energy|
      energy += 1
    end
  end
  
  increased = Array.new(map.size, 0)
  increased.map! { |_| Array.new(map[0].size, 0) }
  
  map.each_with_index do |layer, layer_n|
    layer.each_with_index do |energy, index|
      if energy > 9 && increased[layer_n][index] == 0
        energy_up(map, layer_n, index)
        increased[layer_n][index] = 1
      end
    end
  end
  
  keep_looping = Array.new(map.size, 0)
  keep_looping.map! { |_| Array.new(map[0].size, true) }
  
  while keep_looping.flatten.any?(true)
    map.each_with_index do |layer, layer_n|
      layer.each_with_index do |energy, index|
        if energy > 9 && increased[layer_n][index] == 0
          energy_up(map, layer_n, index)
          increased[layer_n][index] = 1
        end
      end
    end
    
    map.each_with_index do |layer, layer_n|
      layer.each_with_index do |energy, index|
        if energy > 9 && increased[layer_n][index] == 0
          keep_looping[layer_n][index] = true
        else
          keep_looping[layer_n][index] = false
        end
      end
    end
  end
  
  map.each_with_index do |layer, layer_n|
    layer.each_with_index do |energy, index|
      if energy > 9
        map[layer_n][index] = 0
        flash_count += 1
      end
    end
  end
end

p step_count

### Input ###

# target_area_x = 20..30
# target_area_y = -10..-5

target_area_x = 102..157
target_area_y = -146..-90

### Method ###

def display(positions)
  positions.each do |position|
    p position
  end
end

def find_max_height(positions)
  max_height = -1 * Float::INFINITY
  positions.each do |position|
    max_height = position[1] if position[1] > max_height
  end
  return max_height
end

def trajectory(init_velo_x, init_velo_y, target_area_x, target_area_y)
  positions = [[0, 0]]
  step = 1
  loop do
    x_position = positions.last[0] + [0, init_velo_x - (step - 1)].max
    y_position = positions.last[1] + init_velo_y - (step - 1)
    positions << [x_position, y_position]
    step += 1
    if (target_area_x.to_a.include?(x_position) && target_area_y.to_a.include?(y_position)) ||  # within the target area
       (x_position > target_area_x.to_a.max || y_position < target_area_y.to_a.min)  # beyond the target area
      break
    end
  end
  
  return positions if target_area_x.to_a.include?(positions.last[0]) && target_area_y.to_a.include?(positions.last[1])
end

### Parts 1, 2 ###

max_heights = []
count = 0

for x in (0..200).to_a  # guess the range based on the given target area
  for y in (-150..150).to_a
    positions = trajectory(x, y, target_area_x, target_area_y)
    if positions
      max_height = find_max_height(positions)
      max_heights << max_height
      count += 1
    end
  end
end

p max_heights.max
p count

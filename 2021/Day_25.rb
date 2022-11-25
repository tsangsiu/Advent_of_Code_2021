### Methods ###

def display(map)
  map.each do |layer|
    puts layer
  end
end

### Input ###

map = File.read("./Input/Day_25_Input.txt").chomp.split("\n")

WIDTH = map.size
LENGTH = map[0].size

### Part 1 ###

map.each_with_index do |layer, i|
  layer.split('').each_with_index do |point, j|
    if point == '>' && map[i][(j + 1) % LENGTH] == '.'
      map[i][j] = '.'
      map[i][(j + 1) % LENGTH] = '>'
    end
  end
end

map_clone = []
map.each do |layer|
  map_clone << layer.clone
end

map_clone.each_with_index do |layer, i|
  layer.split('').each_with_index do |point, j|
    if point == 'v' && map_clone[(i + 1) % WIDTH] == '.'
      map[i][j] = '.'
      map[(i + 1) % WIDTH][j] = 'v'
    end
  end
end

display(map_clone)
puts ' '
display(map)
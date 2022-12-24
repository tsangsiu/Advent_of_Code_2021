###
### input
###

map = File.read("input.txt").chomp.split("\n").map{ |layer| layer.split('') }

wall = Hash.new(false)
left = Hash.new(false)
right = Hash.new(false)
up = Hash.new(false)
down = Hash.new(false)
map.each_with_index do |layer, row|
  layer.each_with_index do |point, col|
    wall[[row, col]] = true if point == '#'
    left[[row, col]] = true if point == '<'
    right[[row, col]] = true if point == '>'
    up[[row, col]] = true if point == '^'
    down[[row, col]] = true if point == 'v'
  end
end

# returns an array containing all points of ground
def ground(wall, left, right, up, down)
  ground = {}
  ((0..LENGTH + 1).to_a.product((0..WIDTH + 1).to_a) -
    wall.keys - left.keys - right.keys - up.keys - down.keys).each do |point|
      ground[point] = true
  end
  ground
end

def generate_map(wall, left, right, up, down)
  map = []; (LENGTH + 2).times { map << Array.new(WIDTH + 2, '.') }
  wall.keys.each { |y, x| map[y][x] = '#' }
  left.keys.each { |y, x| map[y][x] = '<' }
  right.keys.each { |y, x| map[y][x] = '>' }
  up.keys.each { |y, x| map[y][x] = '^' }
  down.keys.each { |y, x| map[y][x] = 'v' }
  all = wall.keys + left.keys + right.keys + up.keys + down.keys
  duplicate = all.select { |element| all.count(element) > 1 }.uniq
  duplicate.each { |y, x| map[y][x] = all.count([y, x]) }
  map
end

def print_map(wall, left, right, up, down)
  map = generate_map(wall, left, right, up, down)
  map.each do |layer|
    puts layer.join('')
  end
end

def print_route(route)
  max_step = route.keys.map { |point| point.last }.max
  (1..max_step).each do |step|
    p route.select { |point, _| point.last == step }
  end
end

WIDTH = map[0].size - 2
LENGTH = map.size - 2
LCM = WIDTH.lcm(LENGTH)
START = [0, 1]
GOAL = [LENGTH + 1, WIDTH]
DIRECTIONS = [[-1, 0], [1, 0], [0, -1], [0, 1]]

###
### part 1
###

# route = { [START, 0] => [] }
# minute = 0
# terminate = false

# loop do
#   minute += 1

#   left = left.to_a.map do |point|
#     point = point.first
#     point[1] == 1 ? [[point[0], WIDTH], true] : [[point[0], point[1] - 1], true]
#   end.to_h
#   right = right.to_a.map do |point|
#     point = point.first
#     point[1] == WIDTH ? [[point[0], 1], true] : [[point[0], point[1] + 1], true]
#   end.to_h
#   up = up.to_a.map do |point|
#     point = point.first
#     point[0] == 1 ? [[LENGTH, point[1]], true] : [[point[0] - 1, point[1]], true]
#   end.to_h
#   down = down.to_a.map do |point|
#     point = point.first
#     point[0] == LENGTH ? [[1, point[1]], true] : [[point[0] + 1, point[1]], true]
#   end.to_h

#   keys_to_add = []
#   # coordinates of the ground of the current minute
#   ground = ground(wall, left, right, up, down); ground[START] = false
#   route.each_pair do |key, _|
#     next if key.last != minute - 1
#     y, x = key.first
#     point_to_go = false
#     DIRECTIONS.each do |direction|
#       dy, dx = direction
#       if ground[[y + dy, x + dx]]
#         point_to_go = true
#         route[key] << [[y + dy, x + dx], minute]
#         if [y + dy, x + dx] == GOAL
#           puts minute
#           terminate = true
#         end
#         keys_to_add << [[y + dy, x + dx], minute]
#       end
#     end
#     if point_to_go == false
#       route[key] = [[y, x], minute]
#       keys_to_add << [[y, x], minute]
#     end
#   end
#   keys_to_add.each { |key| route[key] = [] }

#   break if terminate
# end

###
### part 2
###

### start -> goal

route = { [START, 0] => [] }
minute = 0
answer1 = nil
terminate = false

loop do
  minute += 1

  left = left.to_a.map do |point|
    point = point.first
    point[1] == 1 ? [[point[0], WIDTH], true] : [[point[0], point[1] - 1], true]
  end.to_h
  right = right.to_a.map do |point|
    point = point.first
    point[1] == WIDTH ? [[point[0], 1], true] : [[point[0], point[1] + 1], true]
  end.to_h
  up = up.to_a.map do |point|
    point = point.first
    point[0] == 1 ? [[LENGTH, point[1]], true] : [[point[0] - 1, point[1]], true]
  end.to_h
  down = down.to_a.map do |point|
    point = point.first
    point[0] == LENGTH ? [[1, point[1]], true] : [[point[0] + 1, point[1]], true]
  end.to_h

  keys_to_add = []
  # coordinates of the ground of the current minute
  ground = ground(wall, left, right, up, down); ground[START] = false
  route.each_pair do |key, _|
    next if key.last != minute - 1
    y, x = key.first
    point_to_go = false
    DIRECTIONS.each do |direction|
      dy, dx = direction
      if ground[[y + dy, x + dx]]
        point_to_go = true
        route[key] << [[y + dy, x + dx], minute]
        if [y + dy, x + dx] == GOAL
          answer1 = minute
          puts answer1
          terminate = true
        end
        keys_to_add << [[y + dy, x + dx], minute]
      end
    end
    if point_to_go == false
      route[key] = [[y, x], minute]
      keys_to_add << [[y, x], minute]
    end
  end
  keys_to_add.each { |key| route[key] = [] }

  break if terminate
end

### goal -> start

route = { [GOAL, 0] => [] }
minute = 0
answer2 = nil
terminate = false

loop do
  minute += 1

  left = left.to_a.map do |point|
    point = point.first
    point[1] == 1 ? [[point[0], WIDTH], true] : [[point[0], point[1] - 1], true]
  end.to_h
  right = right.to_a.map do |point|
    point = point.first
    point[1] == WIDTH ? [[point[0], 1], true] : [[point[0], point[1] + 1], true]
  end.to_h
  up = up.to_a.map do |point|
    point = point.first
    point[0] == 1 ? [[LENGTH, point[1]], true] : [[point[0] - 1, point[1]], true]
  end.to_h
  down = down.to_a.map do |point|
    point = point.first
    point[0] == LENGTH ? [[1, point[1]], true] : [[point[0] + 1, point[1]], true]
  end.to_h

  keys_to_add = []
  # coordinates of the ground of the current minute
  ground = ground(wall, left, right, up, down); ground[GOAL] = false
  route.each_pair do |key, _|
    next if key.last != minute - 1
    y, x = key.first
    point_to_go = false
    DIRECTIONS.each do |direction|
      dy, dx = direction
      if ground[[y + dy, x + dx]]
        point_to_go = true
        route[key] << [[y + dy, x + dx], minute]
        if [y + dy, x + dx] == START
          answer2 = minute
          puts answer2
          terminate = true
        end
        keys_to_add << [[y + dy, x + dx], minute]
      end
    end
    if point_to_go == false
      route[key] = [[y, x], minute]
      keys_to_add << [[y, x], minute]
    end
  end
  keys_to_add.each { |key| route[key] = [] }

  break if terminate
end

### start -> goal

route = { [START, 0] => [] }
minute = 0
answer3 = nil
terminate = false

loop do
  minute += 1

  left = left.to_a.map do |point|
    point = point.first
    point[1] == 1 ? [[point[0], WIDTH], true] : [[point[0], point[1] - 1], true]
  end.to_h
  right = right.to_a.map do |point|
    point = point.first
    point[1] == WIDTH ? [[point[0], 1], true] : [[point[0], point[1] + 1], true]
  end.to_h
  up = up.to_a.map do |point|
    point = point.first
    point[0] == 1 ? [[LENGTH, point[1]], true] : [[point[0] - 1, point[1]], true]
  end.to_h
  down = down.to_a.map do |point|
    point = point.first
    point[0] == LENGTH ? [[1, point[1]], true] : [[point[0] + 1, point[1]], true]
  end.to_h

  keys_to_add = []
  # coordinates of the ground of the current minute
  ground = ground(wall, left, right, up, down); ground[START] = false
  route.each_pair do |key, _|
    next if key.last != minute - 1
    y, x = key.first
    point_to_go = false
    DIRECTIONS.each do |direction|
      dy, dx = direction
      if ground[[y + dy, x + dx]]
        point_to_go = true
        route[key] << [[y + dy, x + dx], minute]
        if [y + dy, x + dx] == GOAL
          answer3 = minute
          puts answer3
          terminate = true
        end
        keys_to_add << [[y + dy, x + dx], minute]
      end
    end
    if point_to_go == false
      route[key] = [[y, x], minute]
      keys_to_add << [[y, x], minute]
    end
  end
  keys_to_add.each { |key| route[key] = [] }

  break if terminate
end

answer = answer1 + answer2 + answer3
puts answer

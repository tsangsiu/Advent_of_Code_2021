###
### input
###

input = File.read("input.txt").chomp.split("\n\n")

map_input = input[0].split("\n")
path = input[1].split('')

### map

MAP_WIDTH = map_input.map(&:length).max
MAP_LENGTH = map_input.size

$map = []
(0...MAP_LENGTH).each do |layer|
  $map << Array.new(MAP_WIDTH, ' ')
  (0...map_input[layer].length).each do |column|
    $map[layer][column] = map_input[layer][column]
  end
end

def print_map
  $map.each do |layer|
    puts layer.join('')
  end
end

### path

START_POINT = [0, $map[0].index { |point| point == '.' }] # [layer, x]
START_DIRECTION = 'R'

path = path.slice_when { |a, b| ['L', 'R'].include?(a) || ['L', 'R'].include?(b) }.to_a
path = path.map { |path| path == ['L'] || path == ['R'] ? path[0] : path.join('').to_i }

def right(pos, step)
  y, x = pos
  $map[y][x] = '.'

  start_at = $map[y].index { |point| point != ' ' }; start_at = start_at.nil? ? 0 : start_at
  path_width = $map[y].reject { |point| point == ' ' }.size

  step.times do
    next_x = start_at + (x - start_at + 1) % path_width
    if $map[y][next_x] != '#'
      x = next_x
    else
      break
    end
  end

  $map[y][x] = '>'
  [y, x]
end

def left(pos, step)
  y, x = pos
  $map[y][x] = '.'

  start_at = $map[y].index { |point| point != ' ' }; start_at = start_at.nil? ? 0 : start_at
  path_width = $map[y].reject { |point| point == ' ' }.size

  step.times do
    next_x = start_at + (x - start_at - 1) % path_width
    if $map[y][next_x] != '#'
      x = next_x
    else
      break
    end
  end

  $map[y][x] = '<'
  [y, x]
end

def up(pos, step)
  y, x = pos
  $map[y][x] = '.'

  start_at = $map.transpose[x].index { |point| point != ' ' }; start_at = start_at.nil? ? 0 : start_at
  path_length = $map.transpose[x].reject { |point| point == ' ' }.size

  step.times do
    next_y = start_at + (y - start_at - 1) % path_length
    if $map[next_y][x] != '#'
      y = next_y
    else
      break
    end
  end

  $map[y][x] = '^'
  [y, x]
end

def down(pos, step)
  y, x = pos
  $map[y][x] = '.'

  start_at = $map.transpose[x].index { |point| point != ' ' }; start_at = start_at.nil? ? 0 : start_at
  path_length = $map.transpose[x].reject { |point| point == ' ' }.size

  step.times do
    next_y = start_at + (y - start_at + 1) % path_length
    if $map[next_y][x] != '#'
      y = next_y
    else
      break
    end
  end

  $map[y][x] = 'v'
  [y, x]
end

def direction(direction, turn)
  if turn == 'L'
    case direction
    when 'U' then 'L'
    when 'D' then 'R'
    when 'L' then 'D'
    when 'R' then 'U'
    end
  elsif turn == 'R'
    case direction
    when 'U' then 'R'
    when 'D' then 'L'
    when 'L' then 'U'
    when 'R' then 'D'
    end
  end
end

###
### part 1
###

point = START_POINT
direction = START_DIRECTION
until path.empty?
  instruction = path.shift
  if instruction.class == Integer # move
    point = case direction
            when 'R' then right(point, instruction)
            when 'D' then down(point, instruction)
            when 'U' then up(point, instruction)
            when 'L' then left(point, instruction)
            end
  else # change direction
    direction = direction(direction, instruction)
  end
end

facing = case direction
         when 'R' then 0
         when 'D' then 1
         when 'L' then 2
         when 'U' then 3
         end
answer = 1000 * (point[0] + 1) + 4 * (point[1] + 1) + facing
puts answer

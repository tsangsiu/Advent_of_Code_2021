###
### input
###

input = File.read("inputex.txt").chomp.split("\n\n")

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
  y, x = pos; direction = 'R'
  $map[y][x] = '.'

  (1..step).each do |i|
    y_old, x_old = y, x
    x += 1

    if x == 12 && (4..8).include?(y) # case 2
      if $map[8][12 + (4 - y % 4) - 1] != '#'
        y, x = 8, 12 + (4 - y % 4) - 1
        return down([y, x], step - i)
      else
        y, x = y_old, x_old
        break
      end
    end

    if $map[y][x] == '#'
      x = x_old; y = y_old
      break
    end
  end

  $map[y][x] = '>'
  [[y, x], direction]
end

def up(pos, step)
  y, x = pos; direction = 'U'
  $map[y][x] = '.'

  (1..step).each do |i|
    y_old, x_old = y, x
    y -= 1

    if (4...8).include?(x) && y == 4 - 1 # case 12
      if $map[x % 4][8] != '#'
        y, x = x % 4, 8
        return right([y, x], step - i)
      else
        y, x = y_old, x_old
        break
      end
    end

    if $map[y][x] == '#'
      y, x = y_old, x_old
      break
    end
  end

  $map[y][x] = '^'
  [[y, x], direction]
end

def down(pos, step)
  y, x = pos; direction = 'D'
  $map[y][x] = '.'

  (1..step).each do |i|
    y_old, x_old = y, x
    y += 1

    if (8...12).include?(x) && y == 12 # case 5
      if $map[7][4 - ((x + 1) % 4)] != '#'
        y, x = 7, 4 - ((x + 1) % 4)
        return up([y, x], step - i)
      else
        y, x = y_old, x_old
        break
      end
    end

    if $map[y][x] == '#'
      y, x = y_old, x_old
      break
    end
  end

  $map[y][x] = 'v'
  [[y, x], direction]
end

def left(pos, step)
  y, x = pos; direction = 'L'
  $map[y][x] = '.'

  (1..step).each do |i|
    y_old, x_old = y, x
    x -= 1

    if $map[y][x] == '#'
      y, x = y_old, x_old
      break
    end
  end

  $map[y][x] = '<'
  [[y, x], direction]
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
### part 2
###

point = START_POINT
direction = START_DIRECTION
until path.empty?
  instruction = path.shift
  if instruction.class == Integer # move
    point, direction = case direction
                       when 'R' then right(point, instruction)
                       when 'D' then down(point, instruction)
                       when 'U' then up(point, instruction)
                       when 'L' then left(point, instruction)
                       end
  else # change direction
    direction = direction(direction, instruction)
  end
end

print_map

facing = case direction
         when 'R' then 0
         when 'D' then 1
         when 'L' then 2
         when 'U' then 3
         end
answer = 1000 * (point[0] + 1) + 4 * (point[1] + 1) + facing
puts answer

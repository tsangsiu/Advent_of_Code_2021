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
  y, x = pos; direction = 'R'
  $map[y][x] = '.'

  (1..step).each do |i|
    y_old, x_old = y, x
    x += 1

    if x == 150 && (0...50).include?(y) # case 4
      if $map[149 - y][99] != '#'
        y, x = 149 - y, 99
        return left([y, x], step - i)
      else
        y, x = y_old, x_old
        break
      end
    elsif x == 100 && (50...100).include?(y) # case 6
      if $map[49][y + 50] != '#'
        y, x = 49, y + 50
        return up([y, x], step - i)
      else
        y, x = y_old, x_old
        break
      end
    elsif x == 100 && (100...150).include?(y) # case 14
      if $map[149 - y][149] != '#'
        y, x = 149 - y, 149
        return left([y, x], step - i)
      else
        y, x = y_old, x_old
        break
      end
    elsif x == 50 && (150...200).include?(y) # case 12
      if $map[149][y - 100] != '#'
        y, x = 149, y - 100
        return up([y, x], step - i)
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

    if (50...100).include?(x) && y == -1 # case 2
      if $map[x + 100][0] != '#'
        y, x = x + 100, 0
        return right([y, x], step - i)
      else
        y, x = y_old, x_old
        break
      end
    elsif (100...150).include?(x) && y == -1 # case 3
      if $map[199][x - 100] != '#'
        y, x = 199, x - 100
        return up([y, x], step - i)
      else
        y, x = y_old, x_old
        break
      end
    elsif (0...50).include?(x) && y == 99 # case 8
      if $map[x + 50][50] != '#'
        y, x = x + 50, 50
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

    if (100...150).include?(x) && y == 50 # case 5
      if $map[x - 50][99] != '#'
        y, x = x - 50, 99
        return left([y, x], step - i)
      else
        y, x = y_old, x_old
        break
      end
    elsif (50...100).include?(x) && y == 150 # case 13
      if $map[x + 100][49] != '#'
        y, x = x + 100, 49
        return left([y, x], step - i)
      else
        y, x = y_old, x_old
        break
      end
    elsif (0...50).include?(x) && y == 200  # case 11
      if $map[0][x + 100] != '#'
        y, x = 0, x + 100
        return down([y, x], step - i)
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

    if x == 49 && (0...50).include?(y) # case 1
      if $map[149 - y][0] != '#'
        y, x = 149 - y, 0
        return right([y, x], step - i)
      else
        y, x = y_old, x_old
        break
      end
    elsif x == 49 && (50...100).include?(y) # case 7
      if $map[100][y - 50] != '#'
        y, x = 100, y - 50
        return down([y, x], step - i)
      else
        y, x = y_old, x_old
        break
      end
    elsif x == -1 && (100...150).include?(y) # case 9
      if $map[149 - y][50] != '#'
        y, x = 149 - y, 50
        return right([y, x], step - i)
      else
        y, x = y_old, x_old
        break
      end
    elsif x == -1 && (150...200).include?(y) # case 10
      if $map[0][y - 100] != '#'
        y, x = 0, y - 100
        return down([y, x], step - i)
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

facing = case direction
         when 'R' then 0
         when 'D' then 1
         when 'L' then 2
         when 'U' then 3
         end
answer = 1000 * (point[0] + 1) + 4 * (point[1] + 1) + facing
puts answer

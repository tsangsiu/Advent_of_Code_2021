###
### input
###

input = File.read("input.txt").chomp.split("\n")

elves = Hash.new(false)
input.each_with_index do |layer, row|
  layer.chars.each_with_index do |char, col|
    elves[[row, col]] = true if char == '#'
  end
end

SURROUNDING = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1]]
DIRECTION = { 1 => [-1, 0], 2 => [1, 0], 3 => [0, -1], 0 => [0, 1] }
CHECK = {
  1 => [[-1, -1], [-1, 0], [-1, 1]],  # north
  2 => [[1, -1], [1, 0], [1, 1]], # south
  3 => [[-1, -1], [0, -1], [1, -1]],  # west
  0 => [[-1, 1], [0, 1], [1, 1]]  # east
}

def generate_map(elves)
  map = []
  y_max = elves.keys.map { |point| point[0] }.max
  x_max = elves.keys.map { |point| point[1] }.max
  (y_max + 2).times { |layer| map << Array.new(x_max + 2, '.') }
  elves.keys.each { |point| map[point[0]][point[1]] = '#' }
  map
end

def print_map(elves)
  map = generate_map(elves)
  map.each { |layer| puts layer.join('') }
end

def answer(elves)
  y_min, y_max = elves.keys.map { |pos| pos.first }.minmax
  x_min, x_max = elves.keys.map { |pos| pos.last }.minmax
  (y_max - y_min + 1) * (x_max - x_min + 1) - elves.size
end

###
### part 1
###

elves_new = elves.clone

1.upto(10) do |round|
  elves_new.keys.each do |elf|
    y, x = elf

    # check the surrounding 8 directions
    good = true
    SURROUNDING.each do |d|
      dy, dx = d
      if elves_new[[y + dy, x + dx]]
        good = false
        break
      end
    end
    if good == true
      elves_new[elf] = elf
      next
    end

    # check for north, south, west, east
    4.times do |i|
      good = true
      CHECK[(round + i) % 4].each do |d|
        dy, dx = d
        if elves_new[[y + dy, x + dx]]
          good = false
          next
        end
      end
      if good == true
        dy, dx = DIRECTION[(round + i) % 4]
        elves_new[elf] = [y + dy, x + dx]
        break
      end
    end
  end

  duplicate = elves_new.values.select do |point|
    elves_new.values.count(point) > 1 && point != true
  end.uniq

  elves_new.each_pair do |old, new|
    elves_new[old] = old if duplicate.include?(new) || new == true
  end

  elves_new = elves_new.to_a.map do |old, new|
    [new, true]
  end.to_h
end

puts answer(elves_new)

###
### part 2
###

round = 0
elves_new = elves.clone

loop do
  round += 1
  elves_old = elves_new.clone

  puts round

  elves_new.keys.each do |elf|
    y, x = elf

    # check the surrounding 8 directions
    good = true
    SURROUNDING.each do |d|
      dy, dx = d
      if elves_new[[y + dy, x + dx]]
        good = false
        break
      end
    end
    if good == true
      elves_new[elf] = elf
      next
    end

    # check for north, south, west, east
    4.times do |i|
      good = true
      CHECK[(round + i) % 4].each do |d|
        dy, dx = d
        if elves_new[[y + dy, x + dx]]
          good = false
          next
        end
      end
      if good == true
        dy, dx = DIRECTION[(round + i) % 4]
        elves_new[elf] = [y + dy, x + dx]
        break
      end
    end
  end

  duplicate = elves_new.values.select do |point|
    elves_new.values.count(point) > 1 && point != true
  end.uniq

  elves_new.each_pair do |old, new|
    elves_new[old] = old if duplicate.include?(new) || new == true
  end

  elves_new = elves_new.to_a.map do |old, new|
    [new, true]
  end.to_h

  break if elves_old == elves_new
end

puts
puts round

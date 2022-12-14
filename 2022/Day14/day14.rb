### input

paths = File.read("input.txt").split("\n")
paths = paths.map { |path| path.split(" -> ") }
PATHS = paths.map { |path| path.map { |path| path.split(',').map(&:to_i) } }

Y_MAX = PATHS.flatten.select.with_index { |_, index| index.odd? }.max
POUR_FROM = [500, 0]

def initialize_blocks
  $blocks = Hash.new(false)  # contains the coordinates of points that are not air (`.`)
  PATHS.each do |path|
    (0...(path.size - 1)).each do |index|
      current_point = path[index]; next_point = path[index + 1]
      if current_point.first != next_point.first
        from, to = [current_point.first, next_point.first].sort
        (from..to).each do |x|
          $blocks[[x, current_point.last]] = true
        end
      elsif current_point.last != next_point.last
        from, to = [current_point.last, next_point.last].sort
        (from..to).each do |y|
          $blocks[[current_point.first, y]] = true
        end
      end
    end
  end
end

### part 1

initialize_blocks

# to simulate one unit of sand
def simulate_sand
  x, y = POUR_FROM

  while y <= Y_MAX # each loop represent one step of sand
    if !$blocks[[x, y + 1]]
      y += 1
      next
    elsif !$blocks[[x - 1, y + 1]]
      x -= 1; y += 1
      next
    elsif !$blocks[[x + 1, y + 1]]
      x += 1; y += 1
      next
    end

    $blocks[[x, y]] = true
    return true # stop
  end

  false # no stop
end

count = 0
loop do
  break unless simulate_sand
  count += 1
end

p count

### part 2

initialize_blocks

(-100_000..100_000).each do |x|
  $blocks[[x, Y_MAX + 2]] = true
end

# to simulate one unit of sand
def simulate_sand
  x, y = POUR_FROM

  while y <= Y_MAX + 2 # each loop represent one step of sand
    if !$blocks[[x, y + 1]]
      y += 1
      next
    elsif !$blocks[[x - 1, y + 1]]
      x -= 1; y += 1
      next
    elsif !$blocks[[x + 1, y + 1]]
      x += 1; y += 1
      next
    end

    $blocks[[x, y]] = true
    return true # stop
  end

  false # no stop
end

count = 0
loop do
  simulate_sand
  count += 1
  break if $blocks[POUR_FROM]
end

p count

### input

grid = File.read("input_test.txt").split("\n").map(&:chars)
n_steps = 4

grid = File.read("input.txt").split("\n").map(&:chars)
n_steps = 100

N_ROW = grid.size
N_COL = grid.first.size

def display(grid)
  grid.each do |layer|
    puts layer.join
  end
end

### part 1

current_grid = []
grid.each { |layer| current_grid << layer.dup }

n_steps.times do
  next_grid = []
  current_grid.each { |layer| next_grid << layer.dup}

  current_grid.each_with_index do |layer, y|
    layer.each_with_index do |light, x|
      on_count = 0
      on_count += 1 if y - 1 >= 0 && x - 1 >= 0 && current_grid[y - 1][x - 1] == "#"
      on_count += 1 if y - 1 >= 0 && current_grid[y - 1][x] == "#"
      on_count += 1 if y - 1 >= 0 && x + 1 < N_COL && current_grid[y - 1][x + 1] == "#"
      on_count += 1 if y >= 0 && x - 1 >= 0 && current_grid[y][x - 1] == "#"
      on_count += 1 if y >= 0 && x + 1 < N_COL && current_grid[y][x + 1] == "#"
      on_count += 1 if y + 1 < N_ROW && x - 1 >= 0 && current_grid[y + 1][x - 1] == "#"
      on_count += 1 if y + 1 < N_ROW && current_grid[y + 1][x] == "#"
      on_count += 1 if y + 1 < N_ROW && x + 1 < N_COL && current_grid[y + 1][x + 1] == "#"

      if light == "#"
        next_grid[y][x] = (on_count == 2 || on_count == 3 ? "#" : ".")
      elsif light == "."
        next_grid[y][x] = (on_count == 3 ? "#" : ".")
      end
    end
  end

  current_grid = []
  next_grid.each { |layer| current_grid << layer.dup}
end

p current_grid.flatten.count("#")

### part 2

grid.first[0] = "#"
grid.first[-1] = "#"
grid.last[0] = "#"
grid.last[-1] = "#"

current_grid = []
grid.each { |layer| current_grid << layer.dup }

n_steps.times do
  next_grid = []
  current_grid.each { |layer| next_grid << layer.dup}

  current_grid.each_with_index do |layer, y|
    layer.each_with_index do |light, x|
      next if (y == 0 && x == 0) || (y == 0 && x == N_COL - 1) ||
                (y == N_ROW - 1 && x == 0) || (y == N_ROW - 1 && x == N_COL - 1)

      on_count = 0
      on_count += 1 if y - 1 >= 0 && x - 1 >= 0 && current_grid[y - 1][x - 1] == "#"
      on_count += 1 if y - 1 >= 0 && current_grid[y - 1][x] == "#"
      on_count += 1 if y - 1 >= 0 && x + 1 < N_COL && current_grid[y - 1][x + 1] == "#"
      on_count += 1 if y >= 0 && x - 1 >= 0 && current_grid[y][x - 1] == "#"
      on_count += 1 if y >= 0 && x + 1 < N_COL && current_grid[y][x + 1] == "#"
      on_count += 1 if y + 1 < N_ROW && x - 1 >= 0 && current_grid[y + 1][x - 1] == "#"
      on_count += 1 if y + 1 < N_ROW && current_grid[y + 1][x] == "#"
      on_count += 1 if y + 1 < N_ROW && x + 1 < N_COL && current_grid[y + 1][x + 1] == "#"

      if light == "#"
        next_grid[y][x] = (on_count == 2 || on_count == 3 ? "#" : ".")
      elsif light == "."
        next_grid[y][x] = (on_count == 3 ? "#" : ".")
      end
    end
  end

  current_grid = []
  next_grid.each { |layer| current_grid << layer.dup}
end

p current_grid.flatten.count("#")

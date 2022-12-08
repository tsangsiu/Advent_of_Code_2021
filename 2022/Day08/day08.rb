# input

grid = File.read("input.txt").split("\n").map { |row| row.split('') }
grid = grid.map { |row| row.map {|num| num.to_i } }
grid_transpose = grid.transpose

# part 1

count = 0

grid.each_with_index do |row, i|
  row.each_with_index do |height, j|
    next unless (1...(grid.size - 1)).include?(i) &&
                  (1...(row.size - 1)).include?(j)

    count += 1 if height > grid[i][0..(j - 1)].max ||
                    height > grid[i][(j + 1)..].max ||
                    height > grid_transpose[j][0..(i - 1)].max ||
                    height > grid_transpose[j][(i + 1)..].max
  end
end

p count + grid.size * 2 + (grid[0].size - 2) * 2

# part 2

scores = []

grid.each_with_index do |row, i|
  row.each_with_index do |height, j|
    next unless (1...(grid.size - 1)).include?(i) &&
                  (1...(row.size - 1)).include?(j)

    left = row[0...j]
    right = row[(j + 1)..]
    up = grid_transpose[j][0..(i - 1)]
    down = grid_transpose[j][(i + 1)..]

    left_index = left.rindex { |element| element >= height }
    left_can_see = left_index.nil? ? left.size : j - left_index

    right_index = right.find_index { |element| element >= height }
    right_can_see = right_index.nil? ? right.size : right_index + 1

    up_index = up.rindex { |element| element >= height }
    up_can_see = up_index.nil? ? up.size : i - up_index

    down_index = down.find_index { |element| element >= height }
    down_can_see = down_index.nil? ? down.size : down_index + 1

    scores << left_can_see * right_can_see * up_can_see * down_can_see
  end
end

puts scores.max

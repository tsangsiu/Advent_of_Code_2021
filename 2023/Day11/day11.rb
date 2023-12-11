### input

input = File.read("input_test.txt").split("\n").map(&:chars)
input = File.read("input.txt").split("\n").map(&:chars)

def display(input)
  input.each do |row|
    puts row.join
  end
end

empty_rows = []
input.each_with_index do |row, index|
  empty_rows << index if row.all? { |pt| pt == "." }
end

empty_cols = []
input.transpose.each_with_index do |col, index|
  empty_cols << index if col.all? { |pt| pt == "." }
end

### part 1

expansion = 2

stars = []
input.each_with_index do |row, r|
  row.each_with_index do |pt, c|
    stars << [r, c] if pt == "#"
  end
end

stars_combination = stars.combination(2).to_a

shortest_dists = []
stars_combination.each do |(y1, x1), (y2, x2)|
  n_empty_rows_in_between = empty_rows.count { |r| r > [y1, y2].min && r < [y1, y2].max }
  n_empty_cols_in_between = empty_cols.count { |c| c > [x1, x2].min && c < [x1, x2].max }
  shortest_dists << (y1 - y2).abs + n_empty_rows_in_between * (expansion - 1) +
                      (x2 - x1).abs + n_empty_cols_in_between * (expansion - 1)
end

puts shortest_dists.sum

### part 2

expansion = 1_000_000

shortest_dists = []
stars_combination.each do |(y1, x1), (y2, x2)|
  n_empty_rows_in_between = empty_rows.count { |r| r > [y1, y2].min && r < [y1, y2].max }
  n_empty_cols_in_between = empty_cols.count { |c| c > [x1, x2].min && c < [x1, x2].max }
  shortest_dists << (y1 - y2).abs + n_empty_rows_in_between * (expansion - 1) +
                      (x2 - x1).abs + n_empty_cols_in_between * (expansion - 1)
end

puts shortest_dists.sum

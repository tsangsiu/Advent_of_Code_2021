### Input ###

instructions = File.read("./Input/Day_13_Input.txt").chomp.split("\n")

coordinates = instructions[0...instructions.index("")]
coordinates.map! do |coordinates|
  coordinates.split(',').map! do |coordinate|
    coordinate.to_i
  end
end

# to find the max row and column
max_col = 0
max_row = 0
coordinates.each do |coordinates|
  max_col = coordinates[0] if coordinates[0] > max_col
  max_row = coordinates[1] if coordinates[1] > max_row
end
MAX_COL = max_col
MAX_ROW = max_row

# to initialise the paper
paper = []
(MAX_ROW + 1).times do
  paper << []
end
paper.each do |row|
  (MAX_COL + 1).times do
    row << ' '
  end
end

coordinates.each do |coordinates|
  x = coordinates[0]
  y = coordinates[1]
  paper[y][x] = '#'
end

# fold instructions
fold_instructions = instructions[(instructions.index("") + 1)..]
fold_instructions.map! do |fold_instruction|
  [fold_instruction.split(' ')[-1].split('=')[0], fold_instruction.split(' ')[-1].split('=')[1].to_i]
end

### Methods ###

def display(paper)
  paper.each do |row|
    puts row.join('')
  end
end

def fold(paper, fold_along, fold_at)
  paper.each_with_index do |row, y|
    row.each_with_index do |column, x|
      if fold_along == 'x'
        if x < fold_at && fold_at - x <= MAX_COL - fold_at  # 
          paper[y][x] = '#' if paper[y][fold_at + fold_at - x] == '#'
        end
      elsif fold_along == 'y'
        if y < fold_at && fold_at - y <= MAX_ROW - fold_at
          paper[y][x] = '#' if paper[fold_at + fold_at - y][x] == '#'
        end
      end
    end
  end
  
  if fold_along == 'x'
    paper = paper.map do |row|
      row[0...fold_at]
    end
  elsif fold_along == 'y'
    paper = paper[0...fold_at]
  end
  
  paper
end

def count_dots(paper)
  count = 0
  paper.each do |row|
    row.each do |dot|
      count += 1 if dot == '#'
    end
  end
  count
end

### Part 1 ###

paper_copy = paper.clone
fold_instructions.each_with_index do |fold_instruction, index|
  if index == 0  # do the first fold only
    fold_along = fold_instruction[0]
    fold_at = fold_instruction[1]
    paper_copy = fold(paper_copy, fold_along, fold_at)
  end
end
p count_dots(paper_copy)

### Part 2 ###

paper_copy = paper.clone
fold_instructions.each_with_index do |fold_instruction, index|
  fold_along = fold_instruction[0]
  fold_at = fold_instruction[1]
  paper_copy = fold(paper_copy, fold_along, fold_at)
end
display(paper_copy)

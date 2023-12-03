### input

input = File.read("input_test.txt").split("\n")
input = File.read("input.txt").split("\n")

### part 1

# to find all numbers' locations
num_location = []  # [row index, col index, length]
input.each_with_index do |row, r| # for every row
  c = 0
  while c < row.length  # for every column
    if row[c] =~ /[^\d]/
      c += 1
    elsif row[c] =~ /\d/
      if row[(c + 1)..].index(/[^\d+]/).nil?
        num_length = row[(c + 1)..].length + 1
        num_location << [r, c, num_length]
        break
      end
      next_non_num_index = c + row[(c + 1)..].index(/[^\d]/) + 1
      num_length = next_non_num_index - c
      num_location << [r, c, num_length]
      c = next_non_num_index + 1
    end
  end
end

# to check the surrounding of each number
part_num_location = []
num_location.each do |r, c, length|
  num_coord = []  # the coordinates of all digits
  length.times do |delta_c|
    num_coord << [r, c + delta_c]
  end

  num_coord.each do |r_idx, c_idx|
    if r_idx - 1 >= 0 && input[r_idx - 1][c_idx] =~ /[^.\d]/  # up
      part_num_location << [r, c, length]
      next
    elsif r_idx + 1 < input.size && input[r_idx + 1][c_idx] =~ /[^.\d]/ # down
      part_num_location << [r, c, length]
      next
    elsif c_idx - 1 >= 0 && input[r_idx][c_idx - 1] =~ /[^.\d]/ # left
      part_num_location << [r, c, length]
      next
    elsif c_idx + 1 < input[r_idx].length && input[r_idx][c_idx + 1] =~ /[^.\d]/  # right
      part_num_location << [r, c, length]
      next
    elsif r_idx - 1 >= 0 && c_idx - 1 >= 0 && input[r_idx - 1][c_idx - 1] =~ /[^.\d]/  # upper-left
      part_num_location << [r, c, length]
      next
    elsif r_idx + 1 < input.size && c_idx - 1 >= 0 && input[r_idx + 1][c_idx - 1] =~ /[^.\d]/  # lower-left
      part_num_location << [r, c, length]
      next
    elsif r_idx - 1 >= 0 && c_idx + 1 < input[r_idx].length && input[r_idx - 1][c_idx + 1] =~ /[^.\d]/  # upper-right
      part_num_location << [r, c, length]
      next
    elsif r_idx + 1 < input.size && c_idx + 1 < input[r_idx].length && input[r_idx + 1][c_idx + 1] =~ /[^.\d]/  # lower-right
      part_num_location << [r, c, length]
      next
    end
  end
end
part_num_location = part_num_location.uniq

# to extract all part numbers
part_num = []
part_num_location.each do |r, c, length|
  part_num << input[r][c, length].to_i
end

puts part_num.sum

### part 2

num_coord = []  # contains the coordinates of all digits
num_location.each do |r, c, length|
  num_coord_temp = []  # the coordinates of all digits
  length.times do |delta_c|
    num_coord_temp << [r, c + delta_c]
  end
  num_coord << num_coord_temp
end

# for every point of "*"
surrounding = []
input.each_with_index do |row, r|
  row.chars.each_with_index do |col, c|
    next unless col == "*"
    surrounding_temp = []

    surrounding_temp << [r - 1, c - 1] if r - 1 >= 0 && c - 1 >= 0
    surrounding_temp << [r - 1, c] if r - 1 >= 0
    surrounding_temp << [r - 1, c + 1] if r - 1 >= 0 && c + 1 < input[r].length

    surrounding_temp << [r, c - 1] if c - 1 >= 0
    surrounding_temp << [r, c + 1] if c + 1 < input[r].length

    surrounding_temp << [r + 1, c - 1] if r + 1 < input.size && c - 1 >= 0
    surrounding_temp << [r + 1, c] if r + 1 < input.size
    surrounding_temp << [r + 1, c + 1] if r + 1 < input.size && c + 1 < input[r].length
    
    surrounding << surrounding_temp    
  end
end

# to select the "*" points which touch exactly two numbers
surrounding = surrounding.select do |surrounding|
  num_coord.count { |coord| !surrounding.intersection(coord).empty? } == 2
end

# to get the coordinates of the target numbers
target_num = []
surrounding.each do |surrounding|
  temp = []
  num_coord.each do |num_coord|
    temp << num_coord if !surrounding.intersection(num_coord).empty?
  end
  target_num << temp
end

# to manipulate the target numbers
target_num = target_num.map do |pairs|
  pairs.map do |num|
    num.map do |r, c|
      input[r][c]
    end.join.to_i
  end
end

puts target_num.map { |pair| pair.reduce(:*) }.sum

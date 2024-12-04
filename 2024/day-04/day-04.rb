# Input

input = File.read("input.txt")
words = input.split("\n").map { |line| line.split("") }

n_row = words.size
n_col = words.first.size

# Part 1

count = 0

(0...n_row).each do |row_idx|
  (0..(n_col - 4)).each do |col_idx|
    if words[row_idx][col_idx, 4] == ["X", "M", "A", "S"] ||
        words[row_idx][col_idx, 4] == ["S", "A", "M", "X"]
      count += 1
    end
  end
end

words_trans = words.transpose
n_row_trans, n_col_trans = n_col, n_row
(0...n_row_trans).each do |row_idx_trans|
  (0..(n_col_trans - 4)).each do |col_idx_trans|
    if words_trans[row_idx_trans][col_idx_trans, 4] == ["X", "M", "A", "S"] ||
        words_trans[row_idx_trans][col_idx_trans, 4] == ["S", "A", "M", "X"]
      count += 1
    end
  end
end

(0..(n_row - 4)).each do |row_idx|
  (0..(n_col - 4)).each do |col_idx|
    if (words[row_idx][col_idx] == "X" &&
        words[row_idx + 1][col_idx + 1] == "M" &&
        words[row_idx + 2][col_idx + 2] == "A" &&
        words[row_idx + 3][col_idx + 3] == "S") ||
       (words[row_idx][col_idx] == "S" &&
        words[row_idx + 1][col_idx + 1] == "A" &&
        words[row_idx + 2][col_idx + 2] == "M" &&
        words[row_idx + 3][col_idx + 3] == "X")
      count += 1
    end
  end
end

(0..(n_row - 4)).each do |row_idx|
  (3...(n_col)).each do |col_idx|
    if (words[row_idx][col_idx] == "X" &&
        words[row_idx + 1][col_idx - 1] == "M" &&
        words[row_idx + 2][col_idx - 2] == "A" &&
        words[row_idx + 3][col_idx - 3] == "S") ||
       (words[row_idx][col_idx] == "S" &&
        words[row_idx + 1][col_idx - 1] == "A" &&
        words[row_idx + 2][col_idx - 2] == "M" &&
        words[row_idx + 3][col_idx - 3] == "X")
      count += 1
    end
  end
end

puts count

# Part 2

count = 0

(0..(n_row - 3)).each do |row_idx|
  (0..(n_col - 3)).each do |col_idx|
    next if words[row_idx + 1][col_idx + 1] != "A"
    if words[row_idx][col_idx] != words[row_idx + 2][col_idx + 2] &&
        words[row_idx][col_idx + 2] != words[row_idx + 2][col_idx] &&
        ["M", "S"].include?(words[row_idx][col_idx]) &&
        ["M", "S"].include?(words[row_idx][col_idx + 2]) &&
        ["M", "S"].include?(words[row_idx + 2][col_idx]) &&
        ["M", "S"].include?(words[row_idx + 2][col_idx + 2]) then
      count += 1
    end
  end
end

puts count

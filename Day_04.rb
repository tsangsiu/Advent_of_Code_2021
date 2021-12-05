require_relative "./Input/Day_04_Input.rb"

def reorganise_boards(boards)
  boards_reorganised = [[[]]]
  n_board = 0
  n_row = 0
  n_col = 0
  boards.each_with_index do |number, index|
    n_element = index + 1
    boards_reorganised[n_board][n_row][n_col] = number.to_i
    n_col += 1
    if n_element % 25 == 0
      n_board += 1
      n_row = 0
      n_col = 0
      boards_reorganised[n_board] = [[]]
    elsif n_element % 5 == 0
      n_row += 1
      n_col = 0
      boards_reorganised[n_board][n_row] = []
    end
  end
  boards_reorganised.pop
  boards_reorganised
end

def check_bingo(board)
  n_number_marked_column = [0, 0, 0, 0, 0]
  board.each do |row|
    n_number_marked_row = 0
    row.each_with_index do |number, index|
      if number.class != Integer
        n_number_marked_row += 1
        n_number_marked_column[index] += 1
      end
      if n_number_marked_row == 5 || n_number_marked_column.include?(5)
        return true
      end
    end
  end
  return false
end

def mark_number(board, draw_number)
  board.each_with_index do |row, row_index|
    row.each_with_index do |number, col_index|
      if number == draw_number
        board[row_index][col_index] = '*'
      end
    end
  end
end

def sum_unmarked_numbers(board)
  sum = 0
  board.each do |row|
    row.each do |number|
      sum += number if number.class == Integer
    end
  end
  sum
end

draw_numbers = Input::DRAW_NUMBERS
boards = Input::BOARDS

### Part 1 ###

bingo = nil
number_called = nil
sum_unmarked = nil

boards_reorganised = reorganise_boards(boards)

draw_numbers.each do |draw_number|
  boards_reorganised.each do |board|
    mark_number(board, draw_number)
    bingo = check_bingo(board)
    if bingo
      number_called = draw_number
      sum_unmarked = sum_unmarked_numbers(board)
      break
    end
  end
  break if bingo
end

result = sum_unmarked * number_called
p number_called, sum_unmarked, result

### Part 2 ###

bingo = nil
number_called = nil
sum_unmarked = nil

boards_reorganised = reorganise_boards(boards)

n_board = boards_reorganised.size
boards_status = Array.new(n_board, 0)

draw_numbers.each do |draw_number|
  boards_reorganised.each_with_index do |board, board_index|
    mark_number(board, draw_number)
    bingo = check_bingo(board)
    if bingo
      boards_status[board_index] = 1
      if boards_status.sum == n_board
        number_called = draw_number
        sum_unmarked = sum_unmarked_numbers(board)
        break
      end
    end
  end
  break if bingo && boards_status.sum == n_board
end

result = sum_unmarked * number_called
p number_called, sum_unmarked, result

digits = File.read("./Input/Day_08_Input.txt").chomp.split("\n").map! { |digit| digit.split('|') }
digits.each do |pair|
  pair.map! do |pattern|
    pattern.chomp.split(' ')
  end
end

### Part 1 ###

count = 0
digits.each do |pair|
  pair[1].each do |pattern|
    count += 1 if pattern.length == 2 || pattern.length == 4 || pattern.length == 3 || pattern.length == 7
  end
end

puts count

### Part 2 ###

def return_segments(segment_board, pattern)
  segment_position = ''
  pattern.split('').each do |segment|
    segment_position << segment_board.key(segment).to_s
  end
  segment_position.split('').sort!.join('')
end

def return_digit(segments)
  case segments.split('').sort.join('')
  when "123567"  then "0"
  when "36"      then "1"
  when "13457"   then "2"
  when "13467"   then "3"
  when "2346"    then "4"
  when "12467"   then "5"
  when "124567"  then "6"
  when "136"     then "7"
  when "1234567" then "8"
  when "123467"  then "9"
  end
end

numbers = []

digits.each do |pair|
  segment_board = { 1 => ' ', 2 => ' ', 3 => ' ', 4 => ' ',
                    5 => ' ', 6 => ' ', 7 => ' ' }

  # Considering patterns with lengths of 4 and 5 (numbers 2, 3, 4, 5), the intersection is the middle segment.
  middle_segment_array = pair[0].select { |pattern| pattern.length == 4 || pattern.length == 5 }
  middle_segment_array.map! { |pattern| pattern.split('') }
  middle_segment = %w(a b c d e f g)
  middle_segment_array.each do |pattern|
    middle_segment = middle_segment & pattern
  end
  segment_board[4] = middle_segment[0]

  # Considering patterns with lengths of 2 and 3 (numbers 1, 7), the odd one is the top segment.
  top_segment_array = pair[0].select { |pattern| pattern.length == 2 || pattern.length == 3 }
  top_segment_array.map! { |pattern| pattern.split('') }.sort_by! { |pattern| pattern.length }
  top_segment = top_segment_array[1] - top_segment_array[0]
  segment_board[1] = top_segment[0]

  # The odd and not-yet-registered segment is the top-left segment.
  top_left_segment_array = pair[0].select { |pattern| pattern.length == 2 || pattern.length == 4 }
  top_left_segment_array.map! { |pattern| pattern.split('') }.sort_by! { |pattern| pattern.length }
  top_left_segment = top_left_segment_array[1] - top_left_segment_array[0]
  top_left_segment.each do |segment|
    segment_board[2] = segment if !segment_board.value?(segment)
  end

  # Considering patterns with lengths of 2 and 6 (numbers 0, 1, 6, 9), the intersection is the bottom-right segment.
  bottom_right_segment_array = pair[0].select { |pattern| pattern.length == 2 || pattern.length == 6 }
  bottom_right_segment_array.map! { |pattern| pattern.split('') }
  bottom_right_segment = %w(a b c d e f g)
  bottom_right_segment_array.each do |pattern|
    bottom_right_segment = bottom_right_segment & pattern
  end
  segment_board[6] = bottom_right_segment[0]

  # Considering the pattern with length of 2 (number 1), the not-yet-registered segment is the top-right segment.
  top_right_segment = pair[0].select { |pattern| pattern.length == 2 }[0]
  top_right_segment.split('').each do |segment|
    segment_board[3] = segment if !segment_board.value?(segment)  
  end

  # The odd and not-yet-registered segment is the bottom segment.
  bottom_segment_array = pair[0].select { |pattern| pattern.length == 5 }
  bottom_segment_array.map! { |pattern| pattern.split('') }
  bottom_segment = %w(a b c d e f g)
  bottom_segment_array.each do |pattern|
    bottom_segment = bottom_segment & pattern
  end
  bottom_segment.each do |segment|
    segment_board[7] = segment if !segment_board.value?(segment)
  end

  remain_segment = %w(a b c d e f g)
  remain_segment.each do |segment|
    segment_board[5] = segment if !segment_board.value?(segment)
  end

  number = ''
  pair[1].each do |pattern|
    segments = return_segments(segment_board, pattern)
    digit = return_digit(segments)
    number << digit.to_s
  end

  numbers << number.to_i
end

p numbers.sum

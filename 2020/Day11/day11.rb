###
### input
###

FLOOR = "."; EMPTY_SEAT = "L"; OCCUPIED_SEAT = "#"
OFFSET = [-1-1i, -1, -1+1i, 1i, 1+1i, 1, 1-1i, -1i]

def print(layout)
  layout.each do |layer|
    puts layer.join("")
  end
end

###
### part 1
###

layout = File.read("input.txt").split("\n").map(&:chars)

layout_clone = []
layout.each do |layer|
  layout_clone << layer.clone
end

# return true if equals state, nil if out-of-range or floor
def is_state?(layout, point, state)
  col_range = 0...layout[0].size
  row_range = 0...layout.size
  col, row = point.rect
  return nil if !row_range.include?(row) || !col_range.include?(col) || layout[row][col] == FLOOR
  layout[row][col] == state
end

loop do
  layout.each_with_index do |layer, y|
    layer.each_with_index do |spot, x|
      next if spot == FLOOR
      curr_point = Complex(x, y)
      if !OFFSET.any? { |offset| is_state?(layout, curr_point + offset, EMPTY_SEAT) == false }
        layout_clone[y][x] = OCCUPIED_SEAT
      elsif OFFSET.count { |offset| is_state?(layout, curr_point + offset, OCCUPIED_SEAT) } >= 4
        layout_clone[y][x] = EMPTY_SEAT
      end
    end
  end

  break if layout_clone == layout

  layout = []
  layout_clone.each { |layer| layout << layer.clone }
end

puts layout.flatten.count(OCCUPIED_SEAT)

###
### part 2
###

layout = File.read("input.txt").split("\n").map(&:chars)

layout_clone = []
layout.each do |layer|
  layout_clone << layer.clone
end

# exptend from the current point in the offset direction till non-floor or out-of-range
# return true if the first-encountered equals state, nil if out-of-range
def is_state?(layout, point, offset, state)
  col_range = 0...layout[0].size
  row_range = 0...layout.size
  col, row = point.rect

  loop do
    point += offset
    col, row = point.rect
    return nil if !row_range.include?(row) || !col_range.include?(col)
    break if [EMPTY_SEAT, OCCUPIED_SEAT].include?(layout[row][col])
  end

  layout[row][col] == state
end

loop do
  layout.each_with_index do |layer, y|
    layer.each_with_index do |spot, x|
      next if spot == FLOOR
      curr_point = Complex(x, y)
      if !OFFSET.any? { |offset| is_state?(layout, curr_point, offset, EMPTY_SEAT) == false }
        layout_clone[y][x] = OCCUPIED_SEAT
      elsif OFFSET.count { |offset| is_state?(layout, curr_point, offset, OCCUPIED_SEAT) } >= 5
        layout_clone[y][x] = EMPTY_SEAT
      end
    end
  end

  break if layout_clone == layout

  layout = []
  layout_clone.each { |layer| layout << layer.clone }
end

puts layout.flatten.count(OCCUPIED_SEAT)

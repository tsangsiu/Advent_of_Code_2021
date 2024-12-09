# Input

input = File.read("input.txt")
map = input.split("\n")

# Part 1

X_MAX = map.first.length - 1
Y_MAX = map.size - 1

init_pos = nil, pos = nil, dir = Complex(0, 1)
map.each_with_index do |row, y|
  next unless row.include?('^')
  x = row.index('^')
  init_pos = Complex(x, Y_MAX - y)
  pos = init_pos
end

pos_been_to = [pos]
loop do
  next_pos = pos + dir
  break unless (0..X_MAX).include?(next_pos.real) && (0..Y_MAX).include?(next_pos.imag)
  if map[Y_MAX - next_pos.imag][next_pos.real] == "#" then
    dir *= Complex(0, -1)
  else
    pos += dir
    pos_been_to << pos
  end
end

pos_been_to.uniq!
puts pos_been_to.size

# Part 2

N_POS = map.first.length * map.size

count = 0
pos_been_to.each do |guard_pos|
  _pos_been_to = []
  pos = init_pos
  dir = Complex(0, 1)
  loop do
    next_pos = pos + dir
    break unless (0..X_MAX).include?(next_pos.real) && (0..Y_MAX).include?(next_pos.imag)
    if map[Y_MAX - next_pos.imag][next_pos.real] == "#" || (next_pos.real == guard_pos.real && next_pos.imag == guard_pos.imag) then
      dir *= Complex(0, -1)
    else
      pos += dir
      _pos_been_to << pos
    end

    if _pos_been_to.size > N_POS
      count += 1
      break
    end
  end
end

puts count

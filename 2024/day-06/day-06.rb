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

been_to = [pos]
loop do
  next_pos = pos + dir
  break unless (0..X_MAX).include?(next_pos.real) && (0..Y_MAX).include?(next_pos.imag)
  if map[Y_MAX - next_pos.imag][next_pos.real] == "#" then
    dir *= Complex(0, -1)
  else
    pos += dir
    been_to << pos
  end
end

been_to.uniq!
puts been_to.size

# Part 2

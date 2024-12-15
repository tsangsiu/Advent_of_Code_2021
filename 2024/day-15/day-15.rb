# Input

input = File.read("input.txt")
map, moves = input.split("\n\n")

map = map.split("\n")
moves = moves.split("\n").map { |moves| moves.split("") }.flatten

DIRS = { "<" => Complex(-1, 0), ">" => Complex(1, 0),
          "v" => Complex(0, 1), "^" => Complex(0, -1) }

def point(pos, map)
  map[pos.imag][pos.real]
end

def print_map(map)
  map.each { |line| puts line }
end

# Part 1

init_pos = nil
map.each_with_index do |line, y|
  next unless line.include?("@")
  init_pos = Complex(line.index("@"), y)
end

pos = init_pos
moves.each do |move|
  dir = DIRS[move]

  next_pos = pos + dir
  if point(next_pos, map) == "#"    
  elsif point(next_pos, map) == "."
    map[pos.imag][pos.real] = "."
    pos = next_pos
    map[pos.imag][pos.real] = "@"
  else
    _pos = pos
    loop do
      _pos += dir
      if point(_pos, map) == "." then
        map[pos.imag][pos.real] = "."
        pos = next_pos
        map[pos.imag][pos.real] = "@"
        map[_pos.imag][_pos.real] = "O"
        break
      elsif point(_pos, map) == "#"
        break
      end
    end
  end
end

sum = 0
map.each_with_index do |layer, y|
  layer.split("").each_with_index do |point, x|
    sum += 100 * y + x if point == "O"
  end
end

puts sum

# Part 2

# map resizing
map = map.map do |line|
  line.split("").map do |point|
    if point == "#" then
      "##"
    elsif point == "O" then
      "[]"
    elsif point == "." then
      ".."
    elsif point == "@" then
      "@."
    end
  end.join("")
end

init_pos = nil
map.each_with_index do |line, y|
  next unless line.include?("@")
  init_pos = Complex(line.index("@"), y)
end

=begin

@[][]   [][]@

@     @
[]   []

[]   []
@     @

@       @       @       @
[][]   [][]   [][]   [][]
 []     []     []     []

 @       @
 []     []
[][]   [][]

[][]   [][]
 []     []
 @       @

 []     []     []     []
[][]   [][]   [][]   [][]
@       @       @       @

=end

pos = init_pos
moves.each do |move|
  dir = DIRS[move]

  next_pos = pos + dir
  if point(next_pos, map) == "#"    
  elsif point(next_pos, map) == "."
    map[pos.imag][pos.real] = "."
    pos = next_pos
    map[pos.imag][pos.real] = "@"
  else

  end
end

# print_map(map)

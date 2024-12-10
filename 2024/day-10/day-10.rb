# Input

input = File.read("input.txt")
MAP = input.split("\n").map { |layer| layer.split("").map(&:to_i) }

C_MAX = MAP.first.size - 1
R_MAX = MAP.size - 1

DIRS = [Complex(0, 1), Complex(1, 0), Complex(0, -1), Complex(-1, 0)]

trailheads = []
MAP.each_with_index do |row, r|
  row.each_with_index do |col, c|
    trailheads << Complex(c, r) if col == 0
  end
end

def out_of_bound?(pos_complex)
  pos_complex.real < 0 || pos_complex.real > C_MAX ||
  pos_complex.imag < 0 || pos_complex.imag > R_MAX
end

def height(pos_complex)
  MAP[pos_complex.imag][pos_complex.real]
end

# Part 1

score = 0
trailheads.each do |trailhead|
  routes = [[trailhead]]
  (0...9).each do |height|
    routes.each do |route|
      curr_pos = route.last
      DIRS.each do |dir|
        next_pos = curr_pos + dir
        routes << route + [next_pos] if !out_of_bound?(next_pos) && height(next_pos) == height(curr_pos) + 1
      end
    end
    routes.delete_if { |route| route.size != height + 2 }
  end
  score += routes.map { |route| route.last }.uniq.size
end

puts score

# Part 2

sum = 0
trailheads.each do |trailhead|
  routes = [[trailhead]]
  (0...9).each do |height|
    routes.each do |route|
      curr_pos = route.last
      DIRS.each do |dir|
        next_pos = curr_pos + dir
        routes << route + [next_pos] if !out_of_bound?(next_pos) && height(next_pos) == height(curr_pos) + 1
      end
    end
    routes.delete_if { |route| route.size != height + 2 }
  end
  sum += routes.size
end

puts sum

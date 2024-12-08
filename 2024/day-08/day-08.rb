# Input

input = File.read("input.txt")
map = input.split("\n").map { |row| row.split("") }

max_r = map.size - 1
max_c = map.first.length - 1

antennas = {}
map.each_with_index do |row, r|
  (0...row.length).each do |c|
    point = row[c]
    next if point == "."
    antennas[point].nil? ? antennas[point] = [Complex(r, c)] : antennas[point] << Complex(r, c)
  end
end

# Part 1

antinodes = []
antennas.each_pair do |freq, locs|
  loc_pairs = locs.combination(2).to_a
  loc_pairs.each do |loc_pair|
    antinodes_1 = loc_pair.last - (loc_pair.first - loc_pair.last)
    antinodes_2 = loc_pair.first - (loc_pair.last - loc_pair.first)
    antinodes << antinodes_1 if antinodes_1.real >= 0 && antinodes_1.real <= max_r &&
                                antinodes_1.imag >= 0 && antinodes_1.imag <= max_c
    antinodes << antinodes_2 if antinodes_2.real >= 0 && antinodes_2.real <= max_r &&
                                antinodes_2.imag >= 0 && antinodes_2.imag <= max_c
  end
end

p antinodes.uniq.size

# Part 2

antinodes = []
antennas.each_pair do |freq, locs|
  loc_pairs = locs.combination(2).to_a
  antinodes << loc_pairs
  loc_pairs.each do |loc_pair|
    n = 1
    loop do
      all_out_of_bound = true

      antinodes_1 = loc_pair.last - (loc_pair.first - loc_pair.last) * n
      antinodes_2 = loc_pair.first - (loc_pair.last - loc_pair.first) * n
      if antinodes_1.real >= 0 && antinodes_1.real <= max_r &&
         antinodes_1.imag >= 0 && antinodes_1.imag <= max_c then
        antinodes << antinodes_1
        all_out_of_bound = false
      end
      if antinodes_2.real >= 0 && antinodes_2.real <= max_r &&
         antinodes_2.imag >= 0 && antinodes_2.imag <= max_c then
        antinodes << antinodes_2
        all_out_of_bound = false
      end

      break if all_out_of_bound
      n += 1
    end
  end
end

p antinodes.flatten.uniq.size

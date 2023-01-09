###
### input
###

input = File.read("input.txt")
map = input.split("\n")

###
### part 1
###

n_row = map.size
pos = (0 + 0i)
count = 0
loop do
  count += 1 if map[pos.imag][pos.real] == "#"
  pos += (3 + 1i)
  pos = Complex(pos.real % map[0].size, pos.imag)
  break if pos.imag >= n_row
end
p count

###
### part 2
###

slopes = [(1 + 1i), (3 + 1i), (5 + 1i), (7 + 1i), (1 + 2i)]

n_row = map.size
counts = []
slopes.each do |slope|
  pos = (0 + 0i)
  count = 0
  loop do
    count += 1 if map[pos.imag][pos.real] == "#"
    pos += slope
    pos = Complex(pos.real % map[0].size, pos.imag)
    if pos.imag >= n_row
      counts << count
      break
    end
  end
end
p counts.reduce(:*)

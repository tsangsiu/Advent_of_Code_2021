###
### input
###

input = File.read("input.txt").split("\n\n").map { |tile| tile.split("\n") }

tiles = {}
input.each do |tile|
  tiles[tile.first.split[1].to_i] = tile[1..]
end

###
### part 1
###

p tiles.keys.size

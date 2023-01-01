###
### input
###

cavern = File.read("input.txt").chomp.split("\n").map { |layer| layer.split('').map(&:to_i) }

def print(cavern)
  cavern.each { |layer| puts layer.join(' ') }
end

###
### part 1
###

# # initialization
# costs = Hash.new(Float::INFINITY)
# visited = Hash.new(false)
# cavern.size.times do |row|
#   cavern[0].size.times do |col|
#     visited[[row, col]] = false
#   end
# end

# # Dijkstra's Algorithm
# current_node = [0, 0] # start node
# costs[current_node] = 0
# loop do
#   row, col = current_node
#   costs[[row + 1, col]] = [costs[current_node] + cavern[row + 1][col], costs[[row + 1, col]]].min if row + 1 < cavern.size
#   costs[[row, col + 1]] = [costs[current_node] + cavern[row][col + 1], costs[[row, col + 1]]].min if col + 1 < cavern[0].size
#   visited[current_node] = true

#   # p unvisited
#   break if visited.values.all? { |value| value == true }

#   next_node = costs.select { |node, cost| visited[node] == false }
#   next_node = next_node.min_by { |node, cost| cost }.first
#   current_node = next_node
# end

# p costs[[cavern.size - 1, cavern[0].size - 1]]

###
### part 2
###

big_cavern = []
cavern.each do |layer|
  big_cavern << layer
end

# to expand the columns
big_cavern = big_cavern.map do |layer|
  current_layer = layer
  1.upto(4) do |i|
    current_layer += layer.map { |point| point + i > 9 ? point + i - 9 : point + i }
  end
  current_layer
end

# to expand the rows
n_row = big_cavern.size
1.upto(4) do |j|
  big_cavern[0...n_row].each do |layer|
    new_layer = layer.map { |point| point + j > 9 ? point + j - 9 : point + j }
    big_cavern << new_layer
  end
end

# initialization
costs = Hash.new(Float::INFINITY)
visited = Hash.new(false)
big_cavern.size.times do |row|
  big_cavern[0].size.times do |col|
    visited[[row, col]] = false
  end
end

# Dijkstra's Algorithm
current_node = [0, 0] # start node
costs[current_node] = 0
loop do
  row, col = current_node
  costs[[row + 1, col]] = [costs[current_node] + big_cavern[row + 1][col], costs[[row + 1, col]]].min if row + 1 < big_cavern.size
  costs[[row, col + 1]] = [costs[current_node] + big_cavern[row][col + 1], costs[[row, col + 1]]].min if col + 1 < big_cavern[0].size
  visited[current_node] = true

  # p unvisited
  break if visited.values.all? { |value| value == true }

  next_node = costs.select { |node, cost| visited[node] == false }
  next_node = next_node.min_by { |node, cost| cost }.first
  current_node = next_node

  p current_node
end

p costs[[big_cavern.size - 1, big_cavern[0].size - 1]]

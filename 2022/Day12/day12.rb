class Graph
  attr_accessor :map

  def initialize
    @map = {}
  end

  def add_vertex(vertex)
    @map[vertex] = [] unless @map.key?(vertex)
  end

  def add_adjacent_vertex(vertex, *adjacent_vertex)
    adjacent_vertex.each do |new_adjacent_vertex|
      add_vertex(vertex) unless @map.key?(vertex)
      add_vertex(new_adjacent_vertex) unless @map.key?(new_adjacent_vertex)
      @map[vertex] << new_adjacent_vertex unless @map[vertex].include?(new_adjacent_vertex)
    end
  end
end

### input

LETTERS = ('a'..'z').to_a

map = File.read("input.txt").split("\n").map{ |layer| layer.split('') }
map = map.map do |layer|
  layer.map do |point|
    LETTERS.include?(point) ? LETTERS.index(point) : point
  end
end

### part 1

# to find the start and end point
start = nil; goal = nil
map.each_with_index do |layer, row|
  layer.each_with_index do |point, col|
    start = [row, col] if point == 'S'
    goal = [row, col] if point == 'E'
  end
  break if !start.nil? && !goal.nil?
end

map[start.first][start.last] = 0
map[goal.first][goal.last] = 25

# to create the graph
graph = Graph.new
graph.add_vertex(start.to_s)
graph.add_vertex(goal.to_s)
map.each_with_index do |layer, row|
  layer.each_with_index do |point, col|
    if col - 1 >= 0 && (map[row][col - 1] <= point + 1) # left
      graph.add_adjacent_vertex([row, col].to_s, [row, col - 1].to_s)
    end
    if col + 1 < layer.size && (map[row][col + 1] <= point + 1) # right
      graph.add_adjacent_vertex([row, col].to_s, [row, col + 1].to_s)
    end
    if row - 1 >= 0 && (map[row - 1][col] <= point + 1) # up
      graph.add_adjacent_vertex([row, col].to_s, [row - 1, col].to_s)
    end
    if row + 1 < map.size && (map[row + 1][col] <= point + 1) # down
      graph.add_adjacent_vertex([row, col].to_s, [row + 1, col].to_s)
    end
  end
end

distances = {}
graph.map.each_key { |key| distances[key] = Float::INFINITY }
distances[start.to_s] = 0
unvisited = graph.map.keys
current_node = start.to_s
loop do
  graph.map[current_node].each do |node|
    distances[node] = [distances[node], distances[current_node] + 1].min
  end
  unvisited.delete(current_node)
  next_node = unvisited.min_by { |node| distances[node] }
  current_node = next_node
  break if unvisited.empty?
end

p distances[goal.to_s]

### part 2

# old algorithm

# lowest_points = []
# map.each_with_index do |layer, row|
#   layer.each_with_index do |point, col|
#     lowest_points << [row, col].to_s if point == 0
#   end
# end

# shortest_distances = []
# lowest_points.each do |point|
#   start = point
#   distances = {}
#   graph.map.each_key { |key| distances[key] = Float::INFINITY }
#   distances[start.to_s] = 0
#   unvisited = graph.map.keys
#   current_node = start.to_s
#   loop do
#     graph.map[current_node].each do |node|
#       distances[node] = [distances[node], distances[current_node] + 1].min
#     end
#     unvisited.delete(current_node)
#     next_node = unvisited.min_by { |node| distances[node] }
#     current_node = next_node
#     break if unvisited.empty?
#   end
#   shortest_distances << distances[goal.to_s]
# end

# p shortest_distances.min

# improved algorithm

start = goal

# to create the graph
graph = Graph.new
graph.add_vertex(start.to_s)
map.each_with_index do |layer, row|
  layer.each_with_index do |point, col|
    if col - 1 >= 0 && (map[row][col - 1] + 1 >= point) # left
      graph.add_adjacent_vertex([row, col].to_s, [row, col - 1].to_s)
    end
    if col + 1 < layer.size && (map[row][col + 1] + 1 >= point) # right
      graph.add_adjacent_vertex([row, col].to_s, [row, col + 1].to_s)
    end
    if row - 1 >= 0 && (map[row - 1][col] + 1 >= point) # up
      graph.add_adjacent_vertex([row, col].to_s, [row - 1, col].to_s)
    end
    if row + 1 < map.size && (map[row + 1][col] + 1 >= point) # down
      graph.add_adjacent_vertex([row, col].to_s, [row + 1, col].to_s)
    end
  end
end

distances = {}
graph.map.each_key { |key| distances[key] = Float::INFINITY }
distances[start.to_s] = 0
unvisited = graph.map.keys
current_node = start.to_s
loop do
  graph.map[current_node].each do |node|
    distances[node] = [distances[node], distances[current_node] + 1].min
  end
  unvisited.delete(current_node)
  next_node = unvisited.min_by { |node| distances[node] }
  current_node = next_node
  break if unvisited.empty?
end

# to get all possible goal points
goals = []
map.each_with_index do |layer, row|
  layer.each_with_index do |point, col|
    goals << [row, col].to_s if point == 0
  end
end

p distances.select { |key, _| goals.include?(key) }.values.min

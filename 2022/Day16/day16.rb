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

input = File.read("inputex.txt").split("\n")

valves = input.map do |line|
  { valve: line.split[1],
    flow_rate: line.split[4][5..].to_i,
    to: line.split[9..].map { |to| to[0..1] } }
end

flow_rates = {}
valves.each do |valve|
  flow_rates[valve[:valve]] = valve[:flow_rate]
end

START = "AA"

# valves.each do |valve|
#   p valve
# end

### part 1

graph = Graph.new
valves.each do |valve|
  graph.add_adjacent_vertex(valve[:valve], *valve[:to])
end

# p graph.map

# breadth-first search
paths = []; queue = []; opened = []
queue << [START]
until queue.empty?

end

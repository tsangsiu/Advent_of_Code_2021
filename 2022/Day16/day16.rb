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

graph = {}
valves.each do |valve|
  graph[valve[:valve]] = valve[:to]
end

START = "AA"

### part 1

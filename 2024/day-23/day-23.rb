# Input

input = File.read("input.txt")
pairs = input.split("\n").map { |pair| pair.split("-") }

connections = {}
pairs.each do |pair|
  if connections.has_key?(pair[0])
    connections[pair[0]] << pair[1]
    connections[pair[0]].uniq!
  else
    connections[pair[0]] = [pair[1]]
  end

  if connections.has_key?(pair[1])
    connections[pair[1]] << pair[0]
    connections[pair[1]].uniq!
  else
    connections[pair[1]] = [pair[0]]
  end
end

# Part 1

desired_connections = []
connections.keys.each do |first_computer|
  connections[first_computer].each do |second_computer|
    connections[second_computer].each do |third_computer|
      connections[third_computer].each do |fourth_computer|
        next if first_computer != fourth_computer
        desired_connections << [first_computer, second_computer, third_computer].sort
      end
    end
  end
end

desired_connections = desired_connections.uniq.select do |connections|
  connections.any? { |computer| computer.start_with?("t") }
end

puts desired_connections.size

### input

input = File.read("input_test_1.txt").split("\n")
input = File.read("input_test_2.txt").split("\n")
input = File.read("input_test_3.txt").split("\n")
input = File.read("input.txt").split("\n")

instruct = input.first.chars
nodes = input[2..]

network = {}
nodes.each do |node|
  left = node[7, 3]; right = node[12, 3]
  network[node[0, 3]] = {"L" => left, "R" => right}
end

### part 1

index = 0
step = 0
current_node = "AAA"
loop do
  step += 1
  dest_node = network[current_node][instruct[index]]
  break if dest_node == "ZZZ"
  current_node = dest_node
  index = (index + 1) % instruct.size
end

puts step

### part 2

steps = []
current_nodes = network.keys.select { |node| node.end_with?("A") }

current_nodes.each do |node|
  index = 0
  step = 0
  current_node = node
  loop do
    step += 1
    dest_node = network[current_node][instruct[index]]
    break if dest_node.end_with?("Z")
    current_node = dest_node
    index = (index + 1) % instruct.size
  end

  steps << step
end

p steps[0].lcm(steps[1]).lcm(steps[2]).lcm(steps[3]).lcm(steps[4]).lcm(steps[5])

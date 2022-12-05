# input

stack1 = ['M','J','C','B','F','R','L','H']
stack2 = ['Z','C','D']
stack3 = ['H','J','F','C','N','G','W']
stack4 = ['P','J','D','M','T','S','B']
stack5 = ['N','C','D','R','J']
stack6 = ['W','L','D','Q','P','J','G','Z']
stack7 = ['P','Z','T','F','R','H']
stack8 = ['L','V','M','G']
stack9 = ['C','B','G','P','F','Q','R','J']
stacks = { 1 => stack1, 2 => stack2, 3 => stack3, 4 => stack4, 5 => stack5, 6 => stack6, 7 => stack7, 8 => stack8, 9 => stack9 }

# stack1 = ['Z','N']
# stack2 = ['M','C','D']
# stack3 = ['P']
# stacks = { 1 => stack1, 2 => stack2, 3 => stack3 }

moves = File.read("input.txt").split("\n")
moves = moves.map { |move| move.split(' ') }
moves = moves.map { |move| [move[1].to_i, move[3].to_i, move[5].to_i] }

# part 1

# moves.each do |move|
#   count = move[0]; from = move[1]; to = move[2]
  
#   count.times do
#     stacks[to] << stacks[from].pop
#   end
# end

# stacks.each_value do |stack|
#   print stack.last
# end
# puts

# part 2

moves.each do |move|
  count = move[0]; from = move[1]; to = move[2]
  stacks[to] += (stacks[from].pop(count)).flatten
end

stacks.each_value do |stack|
  print stack.last
end
puts

require_relative "./Input/Day_02_Input.rb"

commands = Input::COMMANDS

### Part 1 ###

position = 0
depth = 0
number_of_command = commands.size / 2

0.upto(number_of_command - 1) do |index|
  direction = commands[index * 2]
  step = commands[index * 2 + 1].to_i
  case direction
  when "forward" then position += step
  when "up"      then depth -= step
  when "down"    then depth += step
  end
end

answer = position * depth
puts position, depth, answer # => 2162, 1051, 2272262

### Part 2 ### 

position = 0
depth = 0
aim = 0
number_of_command = commands.size / 2

0.upto(number_of_command - 1) do |index|
  direction = commands[index * 2]
  step = commands[index * 2 + 1].to_i
  case direction
  when "forward"
    position += step
    depth += aim * step
  when "up"   then aim -= step
  when "down" then aim += step
  end
end

answer = position * depth
puts position, depth, answer # => 2162, 987457, 2134882034

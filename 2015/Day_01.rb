require_relative "./Input/Day_01_Input.rb"

instructions = Input::INSTRUCTIONS

### Part 1 ###

p instructions.count('(') - instructions.count(')')

### Part 2 ###

instructions_modified = instructions.split('').map do |instruction|
  if instruction == '('
    1
  elsif instruction == ')'
    -1
  end
end

floor = 0
position = 0
instructions_modified.each do |instruction|
  floor += instruction
  position += 1
  break if floor == -1
end

p position

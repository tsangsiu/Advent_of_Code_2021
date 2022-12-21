###
### input
###

input = File.read("input.txt").chomp.split("\n").map { |monkey| monkey.split(': ') }

$monkeys = {}
input.each do |monkey|
  if monkey[1] =~ /\d+/
    $monkeys[monkey[0]] = monkey[1].to_i
  else
    $monkeys[monkey[0]] = monkey[1].split
  end
end

###
### part 1
###

def yell(monkey)
  return $monkeys[monkey] if $monkeys[monkey].class == Integer

  operation = $monkeys[monkey][1]
  monkey1 = $monkeys[monkey][0]
  monkey2 = $monkeys[monkey][2]
  eval("#{yell(monkey1)} #{operation} #{yell(monkey2)}")
end

puts yell('root')

###
### part 2
###

def yell(monkey)
  return "x" if monkey == "humn"
  return $monkeys[monkey] if $monkeys[monkey].class == Integer

  operation = $monkeys[monkey][1]
  monkey1 = $monkeys[monkey][0]
  monkey2 = $monkeys[monkey][2]

  "(#{yell(monkey1)} #{operation} #{yell(monkey2)})"  
end

puts "#{yell($monkeys['root'][0])} = #{yell($monkeys['root'][2])}"
# copy the print text and paste it in the following to solve:
# https://www.mathpapa.com/equation-solver/

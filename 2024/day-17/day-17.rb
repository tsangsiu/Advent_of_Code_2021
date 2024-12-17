# Input

input = File.read("input.txt")
_registers, program = input.split("\n\n")

_registers = _registers.split("\n")
registers = {}
_registers.each do |register|
  registers[register.split(" ")[1][...-1]] = register.split(" ")[2].to_i
end

program = program.split(" ").last.split(",").map { |program| program.to_i }

def operand(combo, registers)
  if [0, 1, 2, 3].include?(combo)
    combo
  elsif combo == 4
    registers["A"]
  elsif combo == 5
    registers["B"]
  elsif combo == 6
    registers["C"]
  end
end

# Part 1

outputs = []

pointer = 0
loop do
  opcode = program[pointer]
  operand = program[pointer + 1]

  if opcode == 0
    registers["A"] /= 2 ** operand(operand, registers)
  elsif opcode == 1
    registers["B"] ^= operand
  elsif opcode == 2
    registers["B"] = operand(operand, registers) % 8
  elsif opcode == 3
    if registers["A"] != 0
      pointer = operand
      pointer -= 2
    end
  elsif opcode == 4
    registers["B"] = registers["B"] ^ registers["C"]
  elsif opcode == 5
    outputs << operand(operand, registers) % 8
  elsif opcode == 6
    registers["B"] = registers["A"] / 2 ** operand(operand, registers)
  elsif opcode == 7
    registers["C"] = registers["A"] / 2 ** operand(operand, registers)
  end

  pointer += 2
  break if pointer > program.size
end

p outputs.join(",")

# Part 2

register_a = 247839539763386
loop do
  registers["A"] = register_a

  outputs = []

  pointer = 0
  loop do
    opcode = program[pointer]
    operand = program[pointer + 1]

    if opcode == 0
      registers["A"] /= 2 ** operand(operand, registers)
    elsif opcode == 1
      registers["B"] ^= operand
    elsif opcode == 2
      registers["B"] = operand(operand, registers) % 8
    elsif opcode == 3
      if registers["A"] != 0
        pointer = operand
        pointer -= 2
      end
    elsif opcode == 4
      registers["B"] = registers["B"] ^ registers["C"]
    elsif opcode == 5
      outputs << operand(operand, registers) % 8
    elsif opcode == 6
      registers["B"] = registers["A"] / 2 ** operand(operand, registers)
    elsif opcode == 7
      registers["C"] = registers["A"] / 2 ** operand(operand, registers)
    end

    pointer += 2
    break if pointer > program.size
  end

  break if outputs == program 
  register_a += 1
end

puts register_a

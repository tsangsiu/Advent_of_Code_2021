###
### input
###

lines = File.read("input.txt").split("\n").map(&:split)
lines = lines.map { |line| [line[0], line[1].to_i] }

###
### part 1
###

pos = 0
acc = 0
ran = Array.new(lines.size, false)
loop do
  if ran[pos]
    puts acc
    break
  end

  ran[pos] = true
  operation, num = lines[pos]

  if operation == "acc"
    acc += num
    pos += 1
  elsif operation == "jmp"
    pos += num
  else
    pos += 1
  end
end

###
### part 2
###

n_lines = lines.size
lines.each_with_index do |line, idx|
  operation, num = line
  next if operation == "acc"

  if operation == "nop"
    lines[idx][0] = "jmp"
  elsif operation == "jmp"
    lines[idx][0] = "nop"
  end

  pos = 0
  acc = 0
  ran = Array.new(lines.size, false)
  loop do
    break if ran[pos]

    ran[pos] = true
    op, n = lines[pos]

    if op == "acc"
      acc += n
      pos += 1
    elsif op == "jmp"
      pos += n
    else
      pos += 1
    end

    if pos >= n_lines
      puts acc
      break
    end
  end

  lines[idx][0] = operation
end

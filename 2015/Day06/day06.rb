### input

instructions = File.read("input.txt").split("\n")

### part 1

grid = Hash.new(0)

instructions.each do |instruction|
  from, _, to = instruction.split[-3..-1]
  x_from, y_from = from.split(',')
  x_to, y_to = to.split(',')
  
  if instruction =~ /turn on/
    (x_from..x_to).each do |x|
      (y_from..y_to).each do |y|
        grid[[x, y]] = 1
      end
    end
  elsif instruction =~ /turn off/
    (x_from..x_to).each do |x|
      (y_from..y_to).each do |y|
        grid[[x, y]] = 0
      end
    end
  elsif instruction =~ /toggle/
    (x_from..x_to).each do |x|
      (y_from..y_to).each do |y|
        if grid[[x, y]] == 0
          grid[[x, y]] = 1
        elsif grid[[x, y]] == 1
          grid[[x, y]] = 0
        end
      end
    end
  end
end

p grid.values.count(1)

### part 2

grid = Hash.new(0)

instructions.each do |instruction|
  from, _, to = instruction.split[-3..-1]
  x_from, y_from = from.split(',')
  x_to, y_to = to.split(',')
  
  if instruction =~ /turn on/
    (x_from..x_to).each do |x|
      (y_from..y_to).each do |y|
        grid[[x, y]] += 1
      end
    end
  elsif instruction =~ /turn off/
    (x_from..x_to).each do |x|
      (y_from..y_to).each do |y|
        grid[[x, y]] -= 1 if grid[[x, y]] > 0
      end
    end
  elsif instruction =~ /toggle/
    (x_from..x_to).each do |x|
      (y_from..y_to).each do |y|
        grid[[x, y]] += 2
      end
    end
  end
end

p grid.values.sum

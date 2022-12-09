# input

motions = File.read("input.txt").split("\n").map { |pair| [pair.split.first, pair.split.last.to_i] }

# part 1

def horizontal?(head_pos, tail_pos)
  head_pos[1] == tail_pos[1]
end

def vertical?(head_pos, tail_pos)
  head_pos[0] == tail_pos[0]
end

def overlap?(head_pos, tail_pos)
  head_pos == tail_pos
end

def together?(head_pos, tail_pos)
  ((head_pos[0] - tail_pos[0]).abs == 1 && horizontal?(head_pos, tail_pos)) || # horizontal
  ((head_pos[1] - tail_pos[1]).abs == 1 && vertical?(head_pos, tail_pos)) || # vertical
  ((head_pos[0] - tail_pos[0]).abs == 1 && (head_pos[1] - tail_pos[1]).abs == 1) || # diagonal
  overlap?(head_pos, tail_pos) # overlap
end

def tail_new_diag_pos(head_pos, tail_pos)
  x_head = head_pos[0]; y_head = head_pos[1]
  x_tail = tail_pos[0]; y_tail = tail_pos[1]
  
  if x_head > x_tail
    return [tail_pos[0] + 1, tail_pos[1] + 1] if y_head > y_tail
    return [tail_pos[0] + 1, tail_pos[1] - 1] if y_head < y_tail
  elsif x_head < x_tail
    return [tail_pos[0] - 1, tail_pos[1] + 1] if y_head > y_tail
    return [tail_pos[0] - 1, tail_pos[1] - 1] if y_head < y_tail
  end
end

START = [0, 0]

# part 1

head_visited = [START]; tail_visited = [START]

motions.each do |motion|
  direction = motion.first
  steps = motion.last

  if direction == 'R'
    steps.times do
      head_new_pos = [head_visited.last[0] + 1, head_visited.last[1]]
      
      if horizontal?(head_new_pos, tail_visited.last) && !together?(head_new_pos, tail_visited.last)
        tail_new_pos = [tail_visited.last[0] + 1, tail_visited.last[1]]
      elsif together?(head_new_pos, tail_visited.last)
        tail_new_pos = tail_visited.last
      else
        tail_new_pos = tail_new_diag_pos(head_new_pos, tail_visited.last)
      end

      head_visited << head_new_pos
      tail_visited << tail_new_pos         
    end
  elsif direction == 'L'
    steps.times do
      head_new_pos = [head_visited.last[0] - 1, head_visited.last[1]]
      
      if horizontal?(head_new_pos, tail_visited.last) && !together?(head_new_pos, tail_visited.last)
        tail_new_pos = [tail_visited.last[0] - 1, tail_visited.last[1]]
      elsif together?(head_new_pos, tail_visited.last)
        tail_new_pos = tail_visited.last
      else
        tail_new_pos = tail_new_diag_pos(head_new_pos, tail_visited.last)
      end
      
      head_visited << head_new_pos
      tail_visited << tail_new_pos
    end
  elsif direction == 'U'
    steps.times do
      head_new_pos = [head_visited.last[0], head_visited.last[1] + 1]
      
      if vertical?(head_new_pos, tail_visited.last) && !together?(head_new_pos, tail_visited.last)
        tail_new_pos = [tail_visited.last[0], tail_visited.last[1] + 1]
      elsif together?(head_new_pos, tail_visited.last)
        tail_new_pos = tail_visited.last
      else
        tail_new_pos = tail_new_diag_pos(head_new_pos, tail_visited.last)
      end
      
      head_visited << head_new_pos
      tail_visited << tail_new_pos
    end
  elsif direction == 'D'
    steps.times do
      head_new_pos = [head_visited.last[0], head_visited.last[1] - 1]
      
      if vertical?(head_new_pos, tail_visited.last) && !together?(head_new_pos, tail_visited.last)
        tail_new_pos = [tail_visited.last[0], tail_visited.last[1] - 1]
      elsif together?(head_new_pos, tail_visited.last)
        tail_new_pos = tail_visited.last
      else
        tail_new_pos = tail_new_diag_pos(head_new_pos, tail_visited.last)
      end
      
      head_visited << head_new_pos
      tail_visited << tail_new_pos
    end
  end
end

puts tail_visited.uniq.size

# part 2

def tail_new_vertical_pos(head_pos, tail_pos)
  y_head = head_pos[1]
  y_tail = tail_pos[1]

  return [tail_pos[0], tail_pos[1] + 1] if y_head > y_tail
  return [tail_pos[0], tail_pos[1] - 1] if y_head < y_tail
end

def tail_new_horizontal_pos(head_pos, tail_pos)
  x_head = head_pos[0]
  x_tail = tail_pos[0]

  return [tail_pos[0] + 1, tail_pos[1]] if x_head > x_tail
  return [tail_pos[0] - 1, tail_pos[1]] if x_head < x_tail
end

NUMBER_OF_KNOTS = 10
knot_pos = Array.new(NUMBER_OF_KNOTS, START)
tail_visited = [START]

motions.each do |motion|
  direction = motion.first
  steps = motion.last
  
  if direction == 'R'
    steps.times do
      knot_pos[0] = [knot_pos.first[0] + 1, knot_pos.first[1]] # head

      (1...knot_pos.size).each do |index|
        if horizontal?(knot_pos[index-1], knot_pos[index]) && !together?(knot_pos[index-1], knot_pos[index])
          knot_pos[index] = tail_new_horizontal_pos(knot_pos[index-1],knot_pos[index])
        elsif vertical?(knot_pos[index-1], knot_pos[index]) && !together?(knot_pos[index-1], knot_pos[index])
          knot_pos[index] = tail_new_vertical_pos(knot_pos[index-1],knot_pos[index])
        elsif together?(knot_pos[index-1], knot_pos[index])
          next
        else
          knot_pos[index] = tail_new_diag_pos(knot_pos[index-1], knot_pos[index])
        end

        tail_visited << knot_pos[index] if index == knot_pos.size - 1    
      end
    end
  elsif direction == 'L'
    steps.times do
      knot_pos[0] = [knot_pos.first[0] - 1, knot_pos.first[1]] # head

      (1...knot_pos.size).each do |index|
        if horizontal?(knot_pos[index-1], knot_pos[index]) && !together?(knot_pos[index-1], knot_pos[index])
          knot_pos[index] =  tail_new_horizontal_pos(knot_pos[index-1],knot_pos[index])
        elsif vertical?(knot_pos[index-1], knot_pos[index]) && !together?(knot_pos[index-1], knot_pos[index])
          knot_pos[index] = tail_new_vertical_pos(knot_pos[index-1],knot_pos[index])
        elsif together?(knot_pos[index-1], knot_pos[index])
          next
        else
          knot_pos[index] = tail_new_diag_pos(knot_pos[index-1], knot_pos[index])
        end

        tail_visited << knot_pos[index] if index == knot_pos.size - 1 
      end
    end
  elsif direction == 'U'
    steps.times do
      knot_pos[0] = [knot_pos.first[0], knot_pos.first[1] + 1] # head

      (1...knot_pos.size).each do |index|
        if vertical?(knot_pos[index-1], knot_pos[index]) && !together?(knot_pos[index-1], knot_pos[index])
          knot_pos[index] = tail_new_vertical_pos(knot_pos[index-1],knot_pos[index])
        elsif horizontal?(knot_pos[index-1], knot_pos[index]) && !together?(knot_pos[index-1], knot_pos[index])
          knot_pos[index] = tail_new_horizontal_pos(knot_pos[index-1],knot_pos[index])
        elsif together?(knot_pos[index-1], knot_pos[index])
          next
        else
          knot_pos[index] = tail_new_diag_pos(knot_pos[index-1], knot_pos[index])
        end

        tail_visited << knot_pos[index] if index == knot_pos.size - 1 
      end
    end
  elsif direction == 'D'
    steps.times do
      knot_pos[0] = [knot_pos.first[0], knot_pos.first[1] - 1] # head
      
      (1...knot_pos.size).each do |index|
        if vertical?(knot_pos[index-1], knot_pos[index]) && !together?(knot_pos[index-1], knot_pos[index])
          knot_pos[index] = tail_new_vertical_pos(knot_pos[index-1],knot_pos[index])
        elsif horizontal?(knot_pos[index-1], knot_pos[index]) && !together?(knot_pos[index-1], knot_pos[index])
          knot_pos[index] = tail_new_horizontal_pos(knot_pos[index-1],knot_pos[index])
        elsif together?(knot_pos[index-1], knot_pos[index])
          next
        else
          knot_pos[index] = tail_new_diag_pos(knot_pos[index-1], knot_pos[index])
        end

        tail_visited << knot_pos[index] if index == knot_pos.size - 1 
      end
    end
  end
end

puts tail_visited.uniq.size

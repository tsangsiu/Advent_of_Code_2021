# input

input = File.read("input.txt").chomp

# part 1

(3..input.length).each do |index|
  if input[(index - 3)..index].split('').uniq.length == 4 
    puts index + 1
    break
  end
end

# part 2

(13..input.length).each do |index|
  if input[(index - 13)..index].split('').uniq.length == 14 
    puts index + 1
    break
  end
end

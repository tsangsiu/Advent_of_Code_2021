# input

commands = File.read("input.txt").split("\n")

# part 1

dir_size = Hash.new(0)
dir_stack = []

commands.each do |command|
  if command == "$ cd /"
    dir_stack = ['.']
  elsif command == "$ cd .."
    dir_stack.pop
  elsif command.start_with?("$ cd ")
    dir_name = command.split(" ").last
    dir_stack << dir_name
  elsif command.split(" ").first =~ /\d+/
    file_size = command.split(" ").first.to_i
    (0...(dir_stack.size)).each do |index|
      dir_name = dir_stack[0..index].join("/")
      dir_size[dir_name] += file_size
    end
  end
end

puts dir_size.values.select { |size| size <= 100_000 }.sum

# part 2

TOTAL_DISK_SPACE = 70_000_000
SPACE_NEEDED = 30_000_000

SPACE_USED = dir_size.values.max
SPACE_REMAINED = TOTAL_DISK_SPACE - SPACE_USED

dir_size.values.sort.each do |size|
  if SPACE_REMAINED + size >= SPACE_NEEDED
    puts size
    break
  end
end

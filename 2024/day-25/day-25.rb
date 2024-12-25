# Input

input = File.read("input.txt").split("\n\n")
keys_locks = input.map { |key_lock| key_lock.split("\n") }

keys = []
locks = []
keys_locks.each do |key_lock|
  key_lock.first == "....." ? keys << key_lock : locks << key_lock
end

keys = keys.map do |key|
  key.map { |key_row| key_row.split("") }
     .transpose
     .map { |key_column| key_column.count("#") - 1 }
end

locks = locks.map do |lock|
  lock.map { |lock_row| lock_row.split("") }
     .transpose
     .map { |lock_column| lock_column.count("#") - 1 }
end

# Part 1

count = 0
locks.each do |lock|
  keys.each do |key|
    count += 1 if (0...5).to_a.all? { |idx| lock[idx] + key[idx] <= 5 }
  end
end

puts count

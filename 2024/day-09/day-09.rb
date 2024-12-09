# Input

input = File.read("input.txt")

# Part 1

disk_map = input.split("").map(&:to_i)

# disk_map_hash = { id: { files: [id, id, ...], n_free: XX } }
disk_map_hash = Hash.new()
disk_map.each_with_index do |disk_map, idx|
  id = idx / 2
  if idx % 2 == 0
    disk_map_hash[id] = { files: [id] * disk_map, n_free: nil }
  else
    disk_map_hash[id][:n_free] = disk_map 
  end
end

disk_map_hash.each_pair do |id, status|
  break if status[:n_free].nil?
  next if status[:n_free] == 0
  loop do
    last_id = disk_map_hash.keys.max
    status[:files] << disk_map_hash[last_id][:files].pop
    status[:n_free] -= 1
    disk_map_hash.delete(last_id) if disk_map_hash[last_id][:files].empty?
    break if status[:n_free] == 0
  end
end

disk = disk_map_hash.map do |hash|
  hash.last[:files]
end.flatten

sum = 0
disk.each_with_index do |id, idx|
  sum += id * idx
end

puts sum

# Part 2

disk_map = input.split("").map(&:to_i)

# disk_map_hash = { id: { files: [id, id, ...], n_free: XX } }
disk_map_hash = Hash.new()
disk_map.each_with_index do |disk_map, idx|
  id = idx / 2
  if idx % 2 == 0
    disk_map_hash[id] = { files: [[id] * disk_map], n_free: nil }
  else
    disk_map_hash[id][:n_free] = disk_map 
  end
end

ids_rev = disk_map_hash.keys.reverse
ids_rev.each do |id_rev|
  file_size = disk_map_hash[id_rev][:files].first.size
  (0...id_rev).each do |id|
    n_free = disk_map_hash[id][:n_free]
    if file_size <= n_free
      disk_map_hash[id][:files] << disk_map_hash[id_rev][:files].first
      disk_map_hash[id_rev][:files][0] = [nil] * disk_map_hash[id_rev][:files].first.size
      disk_map_hash[id][:n_free] -= file_size
      break
    end
  end
end

disk = disk_map_hash.map do |hash|
  files = hash[1][:files]
  n_free = hash[1][:n_free]
  files << [nil] * n_free unless n_free.nil?
end.flatten

sum = 0
disk.each_with_index do |id, idx|
  sum += id * idx unless id.nil?
end

puts sum

### Methods ###

def display(map)
  map.each do |layer|
    p layer
  end
end

### Input ###

map = File.read("./Input/Day_12_Input.txt").chomp.split("\n")

map = map.map do |path|
  path.split('-')
end

# to create the graph
graph = Hash.new()

map.each do |path|
  # initialise keys
  if !graph.key?(path[0]) && path[1] != 'start'
    graph[path[0]] = { next: [path[1]], big_cave: false, small_cave: false, visited: false, n_visit: 0 }
  end
  if !graph.key?(path[1]) && path[0] != 'start'
    graph[path[1]] = { next: [path[0]], big_cave: false, small_cave: false, visited: false, n_visit: 0 } 
  end

  # next node
  graph[path[0]][:next] << path[1] if graph.key?(path[0]) && !graph[path[0]][:next].include?(path[1]) && path[1] != 'start'
  graph[path[1]][:next] << path[0] if graph.key?(path[1]) && !graph[path[1]][:next].include?(path[0]) && path[0] != 'start'
end

# end node
graph['end'] = { next: [], big_cave: false, small_cave: false, visited: false, n_visit: 0 }

# big/small cave
graph.each_pair do |key, value|
  value[:big_cave] = true if key.upcase == key
  value[:small_cave] = true if key.downcase == key && key != 'start' && key != 'end'
end

### Part 1 ###

def print_all_paths(graph, start_node, end_node, all_paths, path)
  graph[start_node][:visited] = true if graph[start_node][:small_cave] == true
  path << start_node
  
  if start_node == end_node
    all_paths << path
    p all_paths.size
  else
    graph[start_node][:next].each do |next_node|
      if graph[next_node][:visited] == false
        print_all_paths(graph, next_node, end_node, all_paths, path)
      end
    end
  end
  
  last_node = path.pop
  graph[last_node][:visited] = false
end

# print_all_paths(graph, 'start', 'end', [], [])

### Part 2 ###

def print_all_paths(graph, start_node, end_node, all_paths, path, small_cave_visit_twice)
  graph[start_node][:n_visit] += 1
  if graph[start_node][:small_cave]
    if graph[start_node][:n_visit] == 2 && !small_cave_visit_twice
      graph[start_node][:visited] = true
      small_cave_visit_twice = true
    elsif graph[start_node][:n_visit] == 1 && small_cave_visit_twice
      graph[start_node][:visited] = true
    end
  end
  
  path << start_node
  
  if start_node == end_node
    all_paths << path
    p all_paths.size
    p path
  else
    graph[start_node][:next].each do |next_node|
      # not visited, and if small cave, small_cave_visit_twice == false
      if !graph[next_node][:visited] && (!graph[next_node][:small_cave] || !small_cave_visit_twice)
        print_all_paths(graph, next_node, end_node, all_paths, path, small_cave_visit_twice)
      end
    end
  end
  
  last_node = path.pop
  if graph[last_node][:small_cave]
    if graph[last_node][:n_visit] == 2 && small_cave_visit_twice
      graph[last_node][:n_visit] -= 1
      graph[last_node][:visited] = false
      small_cave_visit_twice = false
    elsif graph[last_node][:n_visit] == 1 && small_cave_visit_twice
      graph[last_node][:n_visit] -= 1
      graph[last_node][:visited] = false
      small_cave_visit_twice = false
    end
  else
    graph[last_node][:n_visit] -= 1
  end
  # graph[last_node][:visited] = false
end

small_cave_visit_twice = false
print_all_paths(graph, 'start', 'end', [], [], small_cave_visit_twice)

# def print_all_paths(graph, start_node, end_node, all_paths, path, small_cave_visit_twice)

#     graph[start_node][:next].each do |next_node|
#       # not visited, and if small cave, small_cave_visit_twice == false
#       if !graph[next_node][:visited] && (!graph[next_node][:small_cave] || small_cave_visit_twice == false)
#         print_all_paths(graph, next_node, end_node, all_paths, path, small_cave_visit_twice)
#       end
#     end
#   end

#   last_node = path.pop
#   if graph[last_node][:small_cave]
#     graph[last_node][:n_visit] -= 1
#     graph[last_node][:visited] = false
#     small_cave_visit_twice = false if graph[last_node][:n_visit] == 1
#   end
#   # if graph[last_node][:small_cave] && graph[last_node][:n_visit] == 2
#   #   graph[start_node][:visited] = false
#   #   small_cave_visit_twice == false
#   # end
#   # graph[last_node][:n_visit] -= 1
# end

# small_cave_visit_twice = false
# # print_all_paths(graph, 'start', 'end', [], [], small_cave_visit_twice)

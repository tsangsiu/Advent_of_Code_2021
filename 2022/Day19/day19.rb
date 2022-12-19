###
### input
###

input = File.read("inputex.txt").chomp.split("\n")

###
### part 1
###

# minerals = [ore, clay, obsidian, geode]
#              0     1       2       3
# index of the blueprints/max_speed array + 1 = blueprint ID

# depth-first search
def solve(blueprint, max_spend, memo, time, robots, minerals)
  return minerals[3] if time == 0

  # memoization
  key = [time, robots, minerals]
  return memo[key] if memo.key?(key)

  # if not store, calculate it
  max_score = minerals[3] + robots[3] * time # amount of geode when we do nothing

  blueprint.each_with_index do |recipe, mineral|
    next if mineral != 3 && robots[mineral] >= max_spend[mineral] # optimization 1, we don't need more

    # optimization 2
    # instead of reduce the time by 1, see how much time we need to build the robot
    # and immediately jump to that state if possible
    wait_time = 0
    recipe.each_with_index do |resource_amount, resource_type|
      break if robots[resource_type] == 0
      # ceiling because we want more instead of less
      # calculated wait time can be negative
      p resource_amount ###
      # wait_time = [wait_time, ((resource_amount - minerals[resource_type]).to_f / robots[resource_type]).ceil].max

      # if resource_type == 3 # run after last iteration
      #   remaining_time = time - wait_time - 1
      #   next if remaining_time <= 0
      #   _robots = robots.clone
      #   _minerals = [minerals[0] + robots[0] * (wait_time + 1),
      #                 minerals[1] + robots[1] * (wait_time + 1),
      #                 minerals[2] + robots[2] * (wait_time + 1),
      #                 minerals[3] + robots[3] * (wait_time + 1)]
      #   recipe.each do |resource_amount, resource_type|
      #     _minerals[resource_type] -= resource_amount
      #   end
      #   _robots[mineral] += 1
      #   (0..2).each do |i|
      #     _minerals[i] = [_minerals[i], max_spend[i] * remaining_time].min
      #   end
      #   max_score = [max_score, solve(blueprint, max_spend, memo, remaining_time, _robots, _minerals)].max
      # end
    end
  end

  memo[key] = max_score
  max_score
end

total = 0
blueprints = []
# the maximum mineral needed to spend every round for each mineral (for optimization)
# we don't need to keep track of geode, we want it as most as possible
max_spend = []
input.each_with_index do |line, id|
  line = line.split
  blueprints[id] = [[[line[6].to_i, 0]]]
  blueprints[id] << [[line[12].to_i, 0]]
  blueprints[id] << [[line[18].to_i, 0], [line[21].to_i, 1]]
  blueprints[id] << [[line[27].to_i, 0], [line[30].to_i, 2]]

  max_spend[id] = [[line[6].to_i, line[12].to_i, line[18].to_i, line[27].to_i].max]
  max_spend[id] << line[21].to_i
  max_spend[id] << line[30].to_i

  score = solve(blueprints[id], max_spend[id], Hash.new(false), 24, [1, 0, 0, 0], [0, 0, 0, 0])
  total += (id + 1) * score
end

puts total

###
### part 2
###

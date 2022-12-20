###
### input
###

input = File.read("input.txt").chomp.split("\n")

# minerals = [ore, clay, obsidian, geode]
#              0     1       2       3

def solve(blueprint, time)
  # cost for each kind of robot
  costs = [
    [blueprint.split[6].to_i, 0, 0, 0],
    [blueprint.split[12].to_i, 0, 0, 0],
    [blueprint.split[18].to_i, blueprint.split[21].to_i, 0, 0],
    [blueprint.split[27].to_i, 0, blueprint.split[30].to_i, 0]
  ]

  # breadth-first search
  queue = []
  queue << [time, [0, 0, 0, 0], [1, 0, 0, 0]] # initial state: [time, minerals, robots]
  seen = Hash.new(false)
  best = 0
  max_spend = [
    [blueprint.split[6].to_i, blueprint.split[12].to_i, blueprint.split[18].to_i, blueprint.split[27].to_i].max,
    blueprint.split[21].to_i,
    blueprint.split[30].to_i,
    Float::INFINITY
  ] # optimisation here

  until queue.empty?
    time, minerals, robots = queue.shift

    # the minmum number of geodes left at the current state
    minimum_geodes_left = minerals[3] + (time * robots[3])
    best = minimum_geodes_left if minimum_geodes_left > best

    next if time == 0 || seen[[time, minerals, robots]]
    seen[[time, minerals, robots]] = true

    # for each mineral
    (0..3).each do |mineral|
      # we have enough of this robot?
      next if robots[mineral] >= max_spend[mineral]

      # to check if we have the robots to get to where we need to be to build the minerals next

      # for a particular mineral
      # check for its cost, and see we have that robot
      # go to the next mineral if we don't have that robot
      next if costs[mineral].zip(robots).any? { |costs_robots_pair| costs_robots_pair[0] > 0 && costs_robots_pair[1] == 0 }

      # we have the robot, but not the minerals
      # to figure out how long we need to wait for the minerals
      # optimisation here
      wait_time = (costs[mineral].map.with_index do |cost, index|
        cost > 0 && robots[index] > 0 ? ((cost - minerals[index]).to_f / robots[index]).ceil.to_i : 0
      end + [0]).max  # + [0] here, when all negative we will get 0

      next if time - wait_time - 1 <= 0

      # to build a new robot
      new_minerals = minerals.map.with_index do |old_mineral, index|
        old_mineral + robots[index] * (wait_time + 1) - costs[mineral][index]
      end
      new_robots = robots.clone; new_robots[mineral] += 1

      # another optimisation here: what if I have minerals that I don't need at all?
      (0..2).each do |mineral|
        new_minerals[mineral] = [new_minerals[mineral], max_spend[mineral] * (time - wait_time - 1)].min
      end
      
      queue << [time - wait_time - 1, new_minerals, new_robots]
    end
  end

  best
end

###
### part 1
###

answer = 0
input.each_with_index do |line, index|
  puts index  # it lets me know the progress
  answer += (index + 1) * solve(line, 24)
end

p answer

###
### part 2
###

answer = 1
input[0..2].each_with_index do |line, index|
  puts index
  answer *= solve(line, 32)
end

p answer

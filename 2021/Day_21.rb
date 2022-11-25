### Input ###

input = File.read("./Input/Day_21_Input.txt").chomp.split("\n")

player1 = { position: input[0].split(' ')[-1].to_i, score: 0 }
player2 = { position: input[1].split(' ')[-1].to_i, score: 0 }
players = [player1, player2]

### Part 1 ###

die = 1
roll_time = 0

loop do
  roll_time += 1
  player1[:position] += die
  player1[:position] %= 10
  player1[:position] += 10 if player1[:position] == 0
  die += 1
  break if player1[:score] >= 1000
  roll_time += 1
  player1[:position] += die
  player1[:position] %= 10
  player1[:position] += 10 if player1[:position] == 0
  die += 1
  break if player1[:score] >= 1000
  roll_time += 1
  player1[:position] += die
  player1[:position] %= 10
  player1[:position] += 10 if player1[:position] == 0
  player1[:score] += player1[:position]
  die += 1
  break if player1[:score] >= 1000
  roll_time += 1
  player2[:position] += die
  player2[:position] %= 10
  player2[:position] += 10 if player2[:position] == 0
  die += 1
  break if player2[:score] >= 1000
  roll_time += 1
  player2[:position] += die
  player2[:position] %= 10
  player2[:position] += 10 if player2[:position] == 0
  die += 1
  break if player2[:score] >= 1000
  roll_time += 1
  player2[:position] += die
  player2[:position] %= 10
  player2[:position] += 10 if player2[:position] == 0
  player2[:score] += player2[:position]
  die += 1
  break if player2[:score] >= 1000
end

loser_score = Float::INFINITY
players.each do |player|
  loser_score = player[:score] if player[:score] < loser_score
end

answer = loser_score * roll_time
# p answer

### Part 2 ###

roll_time = 20
universes = [1, 2, 3]  # the initial universe when roll_time is 1
(roll_time - 1).times do
  universes = universes.product([1, 2, 3])
  universes.map! do |universe|
    universe.flatten
  end
end

win = Array.new(universes.size, nil)

# to calculate which player wins for each universe
universes.each_with_index do |universe, index|
  universe.each_with_index do |die_outcome, roll_time|
    if [0, 1, 2].include?(roll_time % 6)
      player1[:position] += die_outcome
      player1[:position] %= 10
      player1[:position] += 10 if player1[:position] == 0
      player1[:score] += player1[:position]
      if player1[:score] >= 21
        win[index] = 1
        break
      end
    elsif [3, 4, 5].include?(roll_time % 6)
      play
    end
  end
end

p win.count(1)
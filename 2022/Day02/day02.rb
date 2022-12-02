# input

input = File.read("input.txt")
input = input.split("\n")
strategy = input.map { |input| input.split }

# part 1

score = 0
strategy.each do |response|
  opponent_response = response.first
  my_response = response.last
  if opponent_response == 'A' # rock
    score += (1 + 3) if my_response == 'X' # rock
    score += (2 + 6) if my_response == 'Y' # paper
    score += (3 + 0) if my_response == 'Z' # scissors
  elsif opponent_response == 'B' # paper
    score += (1 + 0) if my_response == 'X' # rock
    score += (2 + 3) if my_response == 'Y' # paper
    score += (3 + 6) if my_response == 'Z' # scissors  
  elsif opponent_response == 'C' # scissors
    score += (1 + 6) if my_response == 'X' # rock
    score += (2 + 0) if my_response == 'Y' # paper
    score += (3 + 3) if my_response == 'Z' # scissors   
  end
end
puts score

# part 2

# X lose, Y draw, Z win

score = 0
strategy.each do |response|
  opponent_response = response.first
  my_response = response.last
  if opponent_response == 'A' # rock
    score += (3 + 0) if my_response == 'X' # lose, scissors
    score += (1 + 3) if my_response == 'Y' # draw, rock
    score += (2 + 6) if my_response == 'Z' # win, paper 
  elsif opponent_response == 'B' # paper
    score += (1 + 0) if my_response == 'X' # lose, rock
    score += (2 + 3) if my_response == 'Y' # draw, paper
    score += (3 + 6) if my_response == 'Z' # win, scissors
  elsif opponent_response == 'C' # scissors
    score += (2 + 0) if my_response == 'X' # lose, paper
    score += (3 + 3) if my_response == 'Y' # draw, scissors
    score += (1 + 6) if my_response == 'Z' # win, rock
  end
end
puts score

require 'digest'

### input

key = 'iwrupvqb'

### part 1

# int = 1

# loop do
#   hash = Digest::MD5.hexdigest(key + int.to_s)
#   break if hash[0...5] == '00000'
#   int += 1
# end

# p int

### part 2

int = 346386  # answer from part 1

loop do
  hash = Digest::MD5.hexdigest(key + int.to_s)
  p int, hash
  break if hash[0...6] == '000000'
  int += 1
end

p int

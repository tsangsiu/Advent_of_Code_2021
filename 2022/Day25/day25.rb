###
### input
###

input = File.read("input.txt").chomp.split("\n")

def to_dec(snafu)
  snafu.split('').reverse.map.each_with_index do |digit, index|
    place_value = case digit
                  when '0', '1', '2' then digit.to_i
                  when '-' then -1
                  when '=' then -2
                  end
    place_value * 5 ** index
  end.sum
end

def to_snafu(dec)
  snafu = ""
  while dec > 0
    remainder = dec % 5; dec /= 5
    if remainder <= 2
      snafu = remainder.to_s + snafu
    else
      snafu = "   =-"[remainder] + snafu
      dec += 1
    end
  end
  snafu
end

sum = input.map do |snafu|
  to_dec(snafu)
end.sum

puts to_snafu(sum)

###
### input
###

input = File.read("input.txt").split("\n")

OPERATORS = { "+" => :+, "*" => :* }

def tokenize(expr)
  expr.gsub(/\(/, " ( ")
      .gsub(/\)/, " ) ")
      .split
      .map { |token| token =~ /\d+/ ? token.to_i : token }
end

###
### part 1
###

# ignore the brackets
def eval1s(expr)
  tokens = tokenize(expr)
  loop do
    return tokens[0] if tokens.size == 1  
    num1 = tokens[0]; num2 = tokens[2]
    op = OPERATORS[tokens[1]]
    tokens[0..2] = [num1, num2].reduce(&op)
  end
end

def eval1(expr)
  return eval1s(expr) unless expr.index("(")
  tokens = tokenize(expr)
  loop do
    left_bracket = tokens.rindex("(")  # the rightmost "("
    right_bracket = left_bracket + tokens[left_bracket + 1..].index(")") + 1  # the first ")" after the above "("
    expr = tokens[(left_bracket + 1)..(right_bracket - 1)].join(' ')
    tokens[left_bracket..right_bracket] = eval1s(expr)
    break unless tokens.index("(")
  end
  expr = tokens.join(" ")
  eval1s(expr)
end

ans = input.map { |expr| eval1(expr) }.sum
puts ans

###
### part 2
###

# ignore the brackets
def eval2s(expr)
  tokens = tokenize(expr)
  loop do
    break unless tokens.index("+")
    plus = tokens.index("+")
    num1, num2 = tokens[plus - 1], tokens[plus + 1]
    tokens[(plus - 1)..(plus + 1)] = num1 + num2
  end
  tokens.select { |token| token.class == Integer }.reduce(&:*)
end

def eval2(expr)
  return eval2s(expr) unless expr.index("(")
  tokens = tokenize(expr)
  loop do
    left_bracket = tokens.rindex("(")  # the rightmost "("
    right_bracket = left_bracket + tokens[left_bracket + 1..].index(")") + 1  # the first ")" after the above "("
    expr = tokens[(left_bracket + 1)..(right_bracket - 1)].join(" ")
    tokens[left_bracket..right_bracket] = eval2s(expr)
    break unless tokens.index("(")
  end
  expr = tokens.join(" ")
  eval2s(expr)
end

ans = input.map { |expr| eval2(expr) }.sum
puts ans

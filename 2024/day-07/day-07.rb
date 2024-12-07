# Input

input = File.read("input.txt")
questions = input.split("\n").map { |question| question.split(": ") }

results = questions.map { |question| question.first.to_i }
operands = questions.map { |question| question.last.split.map(&:to_i) }

# Part 1

operators = {}
min_n_operands = operands.map { |operands| operands.size }.min
max_n_operands = operands.map { |operands| operands.size }.max
(min_n_operands..max_n_operands).each do |n_operands|
  operators[n_operands] = ([:+, :*] * (n_operands - 1)).combination(n_operands - 1).to_a.uniq
end

result_pass = []
results.each_with_index do |result, idx_result|
  pass = false
  n_operand = operands[idx_result].size

  operators[n_operand].each_with_index do |operators, idx_operators|  
    _result = operands[idx_result].first
    operators.each_with_index do |operator, idx_operator|
      if operator == :+ then
        _result = [_result, operands[idx_result][idx_operator + 1]].reduce(&:+)
      elsif operator == :* then
        _result = [_result, operands[idx_result][idx_operator + 1]].reduce(&:*)
      end
    end

    if _result == result then
      result_pass << result
      pass = true
      break
    end
  end
end

puts result_pass.sum

# Part 2

operators = {}
min_n_operands = operands.map { |operands| operands.size }.min
max_n_operands = operands.map { |operands| operands.size }.max
(min_n_operands..max_n_operands).each do |n_operands|
  operators[n_operands] = ([:+, :*, :concat] * (n_operands - 1)).combination(n_operands - 1).to_a.uniq
end

result_pass = []
results.each_with_index do |result, idx_result|
  pass = false
  n_operand = operands[idx_result].size

  operators[n_operand].each_with_index do |operators, idx_operators|  
    _result = operands[idx_result].first
    operators.each_with_index do |operator, idx_operator|
      if operator == :+ then
        _result = [_result, operands[idx_result][idx_operator + 1]].reduce(&:+)
      elsif operator == :* then
        _result = [_result, operands[idx_result][idx_operator + 1]].reduce(&:*)
      elsif operator == :concat then
        _result = (_result.to_s + operands[idx_result][idx_operator + 1].to_s).to_i
      end
    end

    if _result == result then
      result_pass << result
      pass = true
      break
    end
  end
end

puts result_pass.sum

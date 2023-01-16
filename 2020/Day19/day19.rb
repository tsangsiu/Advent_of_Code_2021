###
### part 1
###

rules = File.read("inputex2.txt").split("\n\n")[0].gsub(/"/, "").split("\n")
messages = File.read("inputex2.txt").split("\n\n")[1].split("\n")

rules_hash = {}
rules.each do |line|
  no, rule = line.split(": ")
  rule = rule.split(" | ").map(&:split)
  rule = rule.map do |sub_rule|
    if [["a"], ["b"]].include?(sub_rule)
      sub_rule.flatten[0]
    else
      sub_rule.map(&:to_i)
    end
  end
  rules_hash[no.to_i] = rule
end
rules = rules_hash

done = {}
rules.each do |no, rule|
  done[no] = [["a"], ["b"]].include?(rule)
end

until done.values.all? { |done| done }
  rules.each do |no, rule|
    next unless rule.flatten.all? { |no| done[no] }
    strings = []
    rule.each do |sub_rule|
      str = [""]
      sub_rule.each do |no|
        str = str.product(rules[no]).map(&:join)
      end
      strings << str
    end
    rules[no] = strings.flatten
    done[no] = true
  end
end

ans = messages.select { |message| rules[0].include?(message) }.size
puts ans

###
### part 2
###

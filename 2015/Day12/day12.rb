### input

input = File.read("input.txt")

### part 1

p input.split(/[^(\-\d+)]/).select { |str| str.match(/\d+/) }.map(&:to_i).sum

### part 2

def sum(collection)
  sum = 0

  if collection.class == Hash
    return 0 if collection.values.include?('red')
    collection.values.each { |val| sum += val.class == Integer ? val : sum(val) }
  elsif collection.class == Array
    collection.each { |ele| sum += ele.class == Integer ? ele : sum(ele) }
  end

  sum
end

hash = eval(input)
puts sum(hash)

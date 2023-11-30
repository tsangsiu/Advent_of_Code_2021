### input

input = File.read("input_test.txt").split("\n")
input = File.read("input.txt").split("\n")

rules = input[0..-3]
original_molecule = input[-1]

RULES = {}
rules.each do |rule|
  character, replacement = rule.split(" => ")
  if RULES[character].nil?
    RULES[character] = [replacement]
  else
    RULES[character] << replacement
  end
end

### part 1

new_molecules = []

RULES.each do |character, replacements|
  start_index = 0
  char_length = character.length

  while original_molecule[start_index..].index(character)
    char_index = start_index + original_molecule[start_index..].index(character)

    replacements.each do |replacement|
      new_molecule = original_molecule.dup
      new_molecule[char_index, char_length] = replacement
      new_molecules << new_molecule
    end

    start_index += char_length
  end
end

puts new_molecules.uniq.size

### part 2

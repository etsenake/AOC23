def parse_numbers(input)
  input.split.map(&:to_i)
end

def calculate_diff(input_array, all_diffs = [])
  diff_array = input_array.each_cons(2).map { |first, second| second - first }
  all_diffs << diff_array
  return all_diffs if diff_array.all?(&:zero?)

  calculate_diff(diff_array, all_diffs)
end

def recalculate_sequence(all_diffs, index, row = -2)
  math_sign = index.zero? ? :- : :+
  all_diffs[row].insert(index, all_diffs[row][index].send(math_sign, all_diffs[row + 1][index]))

  return all_diffs if row.abs == all_diffs.length

  recalculate_sequence(all_diffs, index, row - 1)
end

def zero_insertion(input_array, zero_index)
  all_diffs = calculate_diff(input_array, [input_array])

  all_diffs[-1][zero_index] = 0
  recalculate_sequence(all_diffs, zero_index)
end


contents = File.readlines(File.join(__dir__, 'input.txt'))

## PART 1
zero_index_pos = -1
sum = 0
contents.each do |line|
  parsed = parse_numbers line
  new_sequence = zero_insertion(parsed, zero_index_pos)
  sum += new_sequence.first[zero_index_pos]
end
puts "Part 1 Sum: #{sum}"

## PART 2
zero_index_pos = 0
sum = 0
contents.each do |line|
  parsed = parse_numbers line
  new_sequence = zero_insertion(parsed, zero_index_pos)
  sum += new_sequence.first[zero_index_pos]
end

puts "Part 2 Sum: #{sum}"

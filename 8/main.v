import os

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }
	words := input.split('\n')
	solution_1(words)
	solution_2(words)
}

fn solution_1(input []string) {
	mut total_difference := 0
	for word in input {
		total_difference += 2
		mut word_mutated := word[1..word.len - 1]
		if word_mutated.len == 0 {
			continue
		}
		for word_mutated.len > 0 {
			current_char := word_mutated[0]
			if current_char != `\\` {
				word_mutated = word_mutated[1..word_mutated.len]
			} else {
				match word_mutated[1] {
					`\\` {
						total_difference++
						word_mutated = word_mutated[2..word_mutated.len]
					}
					`\"` {
						total_difference++
						word_mutated = word_mutated[2..word_mutated.len]
					}
					`x` {
						total_difference += 3
						word_mutated = word_mutated[4..word_mutated.len]
					}
					else {
						panic('invalid character after first slash')
					}
				}
			}
		}
	}
	println(total_difference)
}

fn solution_2(input []string) {
	mut total_difference := 0
	for word in input {
		total_difference += 2
		for character in word {
			if character in [`\\`, `\"`] {
				total_difference++
			}
		}
	}
	println(total_difference)
}

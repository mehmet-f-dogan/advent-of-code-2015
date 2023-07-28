import os

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }
	words := input.split('\n')
	solution_1(words)
	solution_2(words)
}

fn solution_1(words []string) {
	mut nice_count := 0
	for word in words {
		mut vowel_count := 0
		for character in word.runes() {
			if character in [`a`, `e`, `o`, `u`, `i`] {
				vowel_count++
			}
		}
		mut double_letter_count := 0
		for character in word.runes() {
			if word.contains(character.str() + character.str()) {
				double_letter_count++
				break
			}
		}
		mut forbidden_double_count := 0
		for i := 0; i < word.len - 1; i++ {
			if word.substr(i, i + 2) in ['ab', 'cd', 'pq', 'xy'] {
				forbidden_double_count++
				break
			}
		}
		if vowel_count >= 3 && double_letter_count > 0 && forbidden_double_count == 0 {
			nice_count++
		}
	}
	println(nice_count)
}

fn solution_2(words []string) {
	mut nice_count := 0
	for word in words {
		mut seperate_double_count := 0
		for i := 0; i < word.len - 2; i++ {
			if word[i + 2..word.len].contains(word[i..i + 2]) {
				seperate_double_count++
				break
			}
		}
		mut seperate_same_letter_count := 0
		for i := 0; i < word.len - 2; i++ {
			if word[i] == word[i + 2] {
				seperate_same_letter_count++
				break
			}
		}
		if seperate_double_count > 0 && seperate_same_letter_count > 0 {
			nice_count++
		}
	}
	println(nice_count)
}

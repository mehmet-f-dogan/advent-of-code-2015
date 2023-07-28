import os
import regex


fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }
	solution_1(input)
	solution_2(input)
}

fn solution_1(input string) {
	query := r'-?\d+'
	mut regex_obj := regex.regex_opt(query) or { panic('cannot create regex') }
	mut sum := 0
	numbers := regex_obj.find_all_str(input)
	for number in numbers {
		sum += number.int()
	}
	println(sum)
}

fn solution_2(input string) {
	panic("no support for parsing json to a global type")
}

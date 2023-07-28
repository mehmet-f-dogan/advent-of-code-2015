import os

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }
	solution_1(input)
	solution_2(input)
}

fn solution_1(input string) {
	mut floor := 0
	go_upper_floor_char := '('[0]

	for _, character in input {
		if character == go_upper_floor_char {
			floor++
		} else {
			floor--
		}
	}

	println(floor)
}

fn solution_2(input string) {
	mut floor := 0
	mut first_negative_floor_index := -1
	go_upper_floor_char := '('[0]

	for index, character in input {
		if character == go_upper_floor_char {
			floor++
		} else {
			floor--
		}
		if floor == -1 {
			first_negative_floor_index = index
			break
		}
	}

	println(first_negative_floor_index + 1)
}

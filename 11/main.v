fn main() {
	input := 'vzbxkghb'
	solution_1(input)
	solution_2(input)
}

fn solution_1(input string) string {
	mut current_password := input.bytes()
	mut valid_password := false
	for !valid_password {
		current_password = increment_nums(current_password)
		valid_password = test_three_in_a_row(current_password)
			&& test_no_forbidden_character(current_password) && test_two_pairs(current_password)
	}
	result := current_password.bytestr()
	println(result)
	return result
}

fn solution_2(input string) {
	solution_1(solution_1(input))
}


fn test_three_in_a_row(input []u8) bool {
	for i := 0; i < input.len - 2; i++ {
		diff := [0, input[i + 1] - input[i], input[i + 2] - input[i]]
		if diff == [0, 1, 2] {
			return true
		}
	}
	return false
}

fn test_no_forbidden_character(input []u8) bool {
	for character in input.bytestr().runes() {
		if character in [`i`, `o`, `l`] {
			return false
		}
	}
	return true
}

fn test_two_pairs(input []u8) bool {
	mut deltas := []u8{}
	for i := 1; i < input.len; i++ {
		if input[i] - input[i - 1] == 0 {
			deltas << u8(i - 1)
		}
	}
	for i := 0; i < deltas.len; i++ {
		for j := i + 1; j < deltas.len; j++ {
			if deltas[j] - deltas[i] > 1 {
				return true
			}
		}
	}
	return false
}

fn increment_nums(input []u8) []u8 {
	mut result := input.clone()
	mut carry := true
	mut i := input.len - 1
	for carry == true && i >= 0 {
		result[i]++
		carry = false
		current_digit := result[i]
		if current_digit > `z` {
			result[i] = `a`
			carry = true
		}
		i--
	}
	return result
}

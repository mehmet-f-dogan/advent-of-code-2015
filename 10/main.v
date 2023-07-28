fn main() {
	input := '1113222113'
	solution_1(input)
	solution_2(input)
}

fn solution_1(input string) {
	mut numbers := input.runes().map(fn (r rune) u8 {
		return r - 48
	})
	for i := 0; i < 40; i++ {
		numbers = step(numbers)
	}
	println(numbers.len)
}

fn solution_2(input string) {
	mut numbers := input.runes().map(fn (r rune) u8 {
		return r - 48
	})
	for i := 0; i < 50; i++ {
		numbers = step(numbers)
	}
	println(numbers.len)
}

fn step(input []u8) []u8 {
	mut result := []u8{}
	mut i := 0
	for {
		if i >= input.len {
			break
		}
		mut multiples := 1
		for j := i + 1; j < input.len; j++ {
			if input[i] == input[j] {
				multiples++
			} else {
				break
			}
		}
		i += multiples - 1
		result << u8(multiples)
		result << input[i]
		i++
	}
	return result
}

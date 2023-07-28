import arrays

fn main() {
	solution_1(0)
	solution_2(0)
}

fn solution_1(number_of_gifts int) {
	target_sum_of_divisors := number_of_gifts / 10
	for i := 1; true; i++ {
		if sum_of_divisors(i) >= target_sum_of_divisors {
			println(i)
			break
		}
	}
}

fn solution_2(base_number_of_gifts int) {
	number_of_gifts := base_number_of_gifts / 11
	mut gift_counts := []int{}

	for i := 0; i < number_of_gifts; i++ {
		gift_counts << 0
	}

	mut possible_results := []int{}

	for elf_number := 1; elf_number <= number_of_gifts; elf_number++ {
		for visit_number := 1; visit_number <= 50; visit_number++ {
			house_number := elf_number * visit_number
			if house_number < number_of_gifts {
				gift_counts[house_number] += elf_number
				if gift_counts[house_number] > number_of_gifts {
					possible_results << house_number
				}
			}
		}
	}

	minimum_index := arrays.min(possible_results) or {panic("never")}
	println(minimum_index)
}

fn sum_of_divisors(n int) int {
	mut sum := 0
	for i := 1; i * i <= n; i += 1 {
		if n % i == 0 {
			sum += i
			if i * i != n {
				sum += n / i
			}
		}
	}
	return sum
}

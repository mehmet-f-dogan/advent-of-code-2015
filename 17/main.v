import os
import arrays

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }
	buckets := parse_input(input)
	solution_1(buckets)
	solution_2(buckets)
}

fn solution_1(buckets []int) {
	included_buckets := []int{}
	result := recurse_solution_1(included_buckets, buckets, 0, 150)
	println(result)
}

fn solution_2(buckets []int) {
	included_buckets := []int{}
	configurations := recurse_solution_2(included_buckets, buckets, 0, 150)
	//println(configurations)
	mut min_number_of_buckets := buckets.len
	mut number_of_minimum_configurations := 0

	for configuration in configurations {
		if configuration.len == 0 {
			continue
		}
		if configuration.len < min_number_of_buckets {
			min_number_of_buckets = configuration.len
			number_of_minimum_configurations = 0
		} 
		if configuration.len == min_number_of_buckets {
			number_of_minimum_configurations++
		}
	}

	println(number_of_minimum_configurations)
}

fn recurse_solution_1(included_buckets []int, buckets []int, id int, target int) int {
	if id == buckets.len {
		mut sum := 0
		for bucket_capacity in included_buckets {
			sum += bucket_capacity
		}
		if sum == target {
			return 1
		}
		return 0
	}

	return recurse_solution_1(arrays.concat(included_buckets, buckets[id]), buckets, id + 1, target) +
		recurse_solution_1(included_buckets.clone(), buckets, id + 1, target)
}

fn recurse_solution_2(included_buckets []int, buckets []int, id int, target int) [][]int {
	mut result := [][]int{}
	if id == buckets.len {
		mut sum := 0
		for bucket_capacity in included_buckets {
			sum += bucket_capacity
		}
		if sum == target {
			result << included_buckets
		}
		return result
	}

	included_result := recurse_solution_2(arrays.concat(included_buckets, buckets[id]), buckets, id + 1, target)
	not_included_result := recurse_solution_2(included_buckets.clone(), buckets, id + 1, target)
	result << included_result
	result << not_included_result
	return result
}

fn parse_input(input string) []int {
	mut buckets := []int{}
	lines := input.split('\n')
	for line in lines {
		buckets << line.int()
	}
	return buckets
}

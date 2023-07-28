import os
import arrays

struct Ingredient {
pub:
	name       string
	capacity   int
	durability int
	flavor     int
	texture    int
	calories   int
}

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }

	ingredients := parse_ingredients(input)

	solution_1(ingredients.clone())
	solution_2(ingredients.clone())
}

fn solution_1(ingredients map[string]Ingredient) {
	mut ingredient_map := [][]int{}
	for _, ingredient in ingredients {
		ingredient_map_entry := [
			ingredient.capacity,
			ingredient.durability,
			ingredient.flavor,
			ingredient.texture,
			// ingredient.calories,
		]
		ingredient_map << ingredient_map_entry
	}

	permutations := generate_permutations(100, ingredients.len)
	mut max_evaluation := 0
	for permutation in permutations {
		evaluation := evauate_configuration_solution_1(permutation, ingredient_map, false)
		if evaluation > max_evaluation {
			max_evaluation = evaluation
		}
	}

	println(max_evaluation)
}

fn evauate_configuration_solution_1(usage []int, ingredient_map [][]int, debug bool) int {
	mut results := [0, 0, 0, 0]
	for ingredient_index, ingredient_data in ingredient_map {
		for category_index, category_amount in ingredient_data {
			results[category_index] += usage[ingredient_index] * category_amount
		}
	}

	mut result := 1
	for i_result in results {
		if i_result <= 0 {
			return 0
		}
		result *= i_result
	}
	return result
}

fn solution_2(ingredients map[string]Ingredient) {
	mut ingredient_map := [][]int{}
	for _, ingredient in ingredients {
		ingredient_map_entry := [
			ingredient.capacity,
			ingredient.durability,
			ingredient.flavor,
			ingredient.texture,
			ingredient.calories,
		]
		ingredient_map << ingredient_map_entry
	}

	permutations := generate_permutations(100, ingredients.len)
	mut max_evaluation := 0
	for permutation in permutations {
		evaluation := evauate_configuration_solution_2(permutation, ingredient_map, false)
		if evaluation > max_evaluation {
			max_evaluation = evaluation
		}
	}

	println(max_evaluation)
}

fn evauate_configuration_solution_2(usage []int, ingredient_map [][]int, debug bool) int {
	mut results := [0, 0, 0, 0, 0]
	for ingredient_index, ingredient_data in ingredient_map {
		for category_index, category_amount in ingredient_data {
			results[category_index] += usage[ingredient_index] * category_amount
		}
	}

	mut result := 1
	for result_index, i_result in results {
		if result_index == 4 {
			if i_result != 500 {
				return 0
			}
		}
		if i_result <= 0 {
			return 0
		}
		if result_index != 4 {
			result *= i_result
		}
	}
	return result
}

fn parse_ingredients(input string) map[string]Ingredient {
	mut ingredients := map[string]Ingredient{}

	lines := input.split('\n')
	for line in lines {
		// Split the line by ':'
		parts := line.split(':')

		if parts.len != 2 {
			// Invalid line format, skip
			continue
		}

		name := parts[0].trim_space().to_lower()
		properties := parts[1].trim_space()

		property_values_base := properties.split(',')
		if property_values_base.len != 5 {
			continue
		}

		property_values := property_values_base.map(fn (x string) string {
			return x.trim_space().split(' ')[1]
		})

		capacity := property_values[0].trim_space().int()

		durability := property_values[1].trim_space().int()

		flavor := property_values[2].trim_space().int()

		texture := property_values[3].trim_space().int()

		calories := property_values[4].trim_space().int()

		ingredients[name] = Ingredient{
			name: name
			capacity: capacity
			durability: durability
			flavor: flavor
			texture: texture
			calories: calories
		}
	}
	return ingredients
}

fn generate_permutations(n int, m int) [][]int {
	mut base_array := []int{}
	return permutation_helper(n, m, mut base_array)
}

fn permutation_helper(total int, remaining_buckets int, mut current []int) [][]int {
	mut result := [][]int{}

	if remaining_buckets == 1 {
		result << arrays.concat(current, total)
		return result
	}

	for i in 0 .. (total + 1) {
		mut current_bucket := arrays.concat(current, i)
		sub_result := permutation_helper(total - i, remaining_buckets - 1, mut current_bucket)
		for sub in sub_result {
			result << sub
		}
	}

	return result
}

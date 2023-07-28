import os
import arrays

struct Path {
pub:
	from     string
	to       string
	distance int
}

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }
	paths := parse_input(input)
	solution_1(paths)
	solution_2(paths)
}

fn solution_1(paths []Path) {
	mut distance_map := map[string]map[string]int{}
	mut all_destinations := []string{}
	for path in paths {
		if path.to !in all_destinations {
			all_destinations << path.to
			distance_map[''][path.to] = 0
			distance_map[path.to][''] = 0
		}
		if path.from !in all_destinations {
			all_destinations << path.from
			distance_map[''][path.from] = 0
			distance_map[path.from][''] = 0
		}
		distance_map[path.from][path.to] = path.distance
		distance_map[path.to][path.from] = path.distance
	}
	result := recursive_path_distance(true, [], all_destinations, '', 0, &distance_map)
	println(result)
}

fn solution_2(paths []Path) {
	mut distance_map := map[string]map[string]int{}
	mut all_destinations := []string{}
	for path in paths {
		if path.to !in all_destinations {
			all_destinations << path.to
			distance_map[''][path.to] = 0
			distance_map[path.to][''] = 0
		}
		if path.from !in all_destinations {
			all_destinations << path.from
			distance_map[''][path.from] = 0
			distance_map[path.from][''] = 0
		}
		distance_map[path.from][path.to] = path.distance
		distance_map[path.to][path.from] = path.distance
	}
	result := recursive_path_distance(false, [], all_destinations, '', 0, &distance_map)
	println(result)
}

fn recursive_path_distance(shortest bool, visited []string, remaining []string, current_pos string, current_distance int, distance_map &map[string]map[string]int) int {
	if remaining.len == 0 {
		return current_distance
	}
	mut results := []int{}

	for remaining_destination in remaining {
		mut new_visited := visited.clone()
		new_visited << remaining_destination
		unsafe {
			results << recursive_path_distance(shortest, new_visited, remaining.filter(it != remaining_destination),
				remaining_destination, distance_map[current_pos][remaining_destination] +
				current_distance, distance_map)
		}
	}
	if shortest {
		return arrays.min(results) or { panic("results are empty") }
	} else {
		return arrays.max(results) or { panic("results are empty") }
	}
}

fn parse_input(input string) []Path {
	mut paths := []Path{}

	for line in input.split('\n') {
		if line == '' {
			continue
		}

		parts := line.split(' ')
		if parts.len != 5 {
			continue
		}

		from := parts[0]
		to := parts[2]
		distance := int(parts[4].parse_int(10, 32) or { 0 })

		path := Path{
			from: from
			to: to
			distance: distance
		}

		paths << path
	}

	return paths
}

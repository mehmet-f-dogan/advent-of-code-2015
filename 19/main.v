import os
import datatypes

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }
	rules, base := parse_input(input)

	solution_1(rules, base)
}

fn solution_1(rules [][]string, base string) {
	mut set := datatypes.Set[string]{}
	for rule in rules {
		transformations := apply_transform(rule[0], rule[1], base)
		set.add_all(transformations)
	}
	println(set.size())
}

fn apply_transform(from string, to string, base string) []string {
	mut results := datatypes.Set[string]{}
	mut search_index := base.index_after(from, 0)
	for search_index != -1 {
		prev := base[0..search_index]
		next := base[search_index + from.len..base.len]
		results.add(prev + to + next)
		search_index = base.index_after(from, search_index + 1)
	}
	return results.elements.keys()
}

fn parse_input(input string) ([][]string, string) {
	lines := input.split('\n')
	mut base := ''
	mut results := [][]string{}

	for index, line in lines {
		if line == '' {
			continue
		}
		if index == (lines.len - 1) {
			base = line.trim_space()
			continue
		}
		tokens := line.split('=>')
		in_material := tokens[0].trim_space()
		out_material := tokens[1].trim_space()
		results << [in_material, out_material]
	}
	return results, base
}

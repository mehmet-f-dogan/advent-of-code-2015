import os
import arrays

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }
	lookup := extract_map(input)
	solution_1(lookup)
	solution_2(lookup)
}

fn solution_1(lookup map[string]map[string]int) {
	people := lookup.keys()
	println(recurse([], people, 0, &lookup))
}

fn solution_2(lookup map[string]map[string]int) {
	processed_people := lookup.keys()
	mut people := lookup.keys()
	people << "me"
	mut lookup_clone := lookup.clone()
	for person in processed_people{
		lookup_clone[person]["me"]=0
		lookup_clone["me"][person]=0
	} 
	println(recurse([], people, 0, &lookup_clone))
}

fn recurse(seated []string, not_seated []string, current_happiness int, lookup &map[string]map[string]int) int{
	if not_seated.len == 0 {
		unsafe {
			return current_happiness + lookup[seated[seated.len - 1]][seated[0]] + lookup[seated[0]][seated[seated.len - 1]]
		}
	}
	results := []int{}
	for person in not_seated {
		unsafe {
			mut new_seated := seated.clone()
			new_seated << person
			new_not_seated := not_seated.clone().filter(it!=person)
			mut new_happiness := 0
			if seated.len > 0 {
				new_happiness = current_happiness + lookup[seated[seated.len - 1]][person] + lookup[person][seated[seated.len - 1]]
			}
			results << recurse(new_seated, new_not_seated, new_happiness, lookup)
		}	
	}
	return arrays.max(results) or { panic("empty array") }
}

fn extract_map(input string) map[string]map[string]int {
	mut return_map := map[string]map[string]int{}
	lines := input.split('\n')
	for line in lines {
		if line == '' {
			continue
		}
		tokens := line.split(' ')
		p1 := tokens[0]
		p2 := tokens[10].split('.')[0]
		mut amount := tokens[3].int()
		change := tokens[2]
		if change == "lose" {
			amount *= -1
		}
		return_map[p1][p2] = amount
	}
	return return_map
}

import os
import datatypes

struct Home {
pub:
	x int
	y int
}

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }
	runes := input.runes()
	solution_1(runes)
	solution_2(runes)
}

fn solution_1(input []rune) {
	mut home_set := datatypes.Set[string]{}
	mut current_home := &Home{0, 0}
	home_set.add('0,0')
	for _, direction in input {
		current_home = match direction {
			`<` { &Home{current_home.x - 1, current_home.y} }
			`>` { &Home{current_home.x + 1, current_home.y} }
			`^` { &Home{current_home.x, current_home.y + 1} }
			`v` { &Home{current_home.x, current_home.y - 1} }
			else { continue }
		}
		home_set.add(current_home.x.str() + ',' + current_home.y.str())
	}
	println(home_set.size())
}

fn solution_2(input []rune) {
	mut home_set := datatypes.Set[string]{}
	mut santa_home := &Home{0, 0}
	mut robot_home := &Home{0, 0}
	home_set.add('0,0')
	mut is_santa_turn := true
	for _, direction in input {
		mut current_home := &robot_home
		println(robot_home)
		if is_santa_turn {
			current_home = &santa_home
		}
		unsafe {
			*current_home = match direction {
				`<` { &Home{current_home.x - 1, current_home.y} }
				`>` { &Home{current_home.x + 1, current_home.y} }
				`^` { &Home{current_home.x, current_home.y + 1} }
				`v` { &Home{current_home.x, current_home.y - 1} }
				else { continue }
			}
		}
		home_set.add(current_home.x.str() + ',' + current_home.y.str())
		is_santa_turn = !is_santa_turn
	}
	println(home_set.size())
}

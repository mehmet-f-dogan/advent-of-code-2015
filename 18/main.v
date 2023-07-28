module main

import os

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }
	solution_1(input)
	solution_2(input)
}

fn solution_1(input string) {
	mut state := input
	for _ in 0 .. 100 {
		state = conways_game_of_life_solution_1(state)
	}
	mut alive := 0
	for character in state {
		if character == `#` {
			alive++
		}
	}
	println(alive)
}

fn solution_2(input string) {
	mut state := input
	for _ in 0 .. 100 {
		state = conways_game_of_life_solution_2(state)
	}
	mut alive := 0
	for character in state {
		if character == `#` {
			alive++
		}
	}
	println(alive)
}

fn conways_game_of_life_solution_1(input string) string {
	neighbors := [-1, 0, 1]
	mut result := ''

	lines := input.split('\n')
	for i, line in lines {
		for j, ch in line {
			if ch == `#` {
				mut alive := 0
				for dx in neighbors {
					for dy in neighbors {
						if dx == 0 && dy == 0 {
							continue
						}
						x, y := i + dx, j + dy
						if x >= 0 && x < lines.len && y >= 0 && y < line.len && lines[x][y] == `#` {
							alive++
						}
					}
				}
				if alive == 2 || alive == 3 {
					result += '#'
				} else {
					result += '.'
				}
			} else {
				mut dead := 0
				for dx in neighbors {
					for dy in neighbors {
						if dx == 0 && dy == 0 {
							continue
						}
						x, y := i + dx, j + dy
						if x >= 0 && x < lines.len && y >= 0 && y < line.len && lines[x][y] == `#` {
							dead++
						}
					}
				}
				if dead == 3 {
					result += '#'
				} else {
					result += '.'
				}
			}
		}
		result += '\n'
	}
	return result.trim_space()
}

fn conways_game_of_life_solution_2(input string) string {
	neighbors := [-1, 0, 1]
	mut result := ''

	lines := input.split('\n')
	for i, line in lines {
		for j, ch in line {
			if ch == `#` {
				mut alive := 0
				for dx in neighbors {
					for dy in neighbors {
						if dx == 0 && dy == 0 {
							continue
						}
						x, y := i + dx, j + dy
						if x >= 0 && x < lines.len && y >= 0 && y < line.len && lines[x][y] == `#` {
							alive++
						}
					}
				}
				if [i, j] in [[0, 0], [0, line.len - 1], [lines.len - 1, 0],
					[lines.len - 1, line.len - 1]] {
					result += '#'
				} else {
					if alive == 2 || alive == 3 {
						result += '#'
					} else {
						result += '.'
					}
				}
			} else {
				mut dead := 0
				for dx in neighbors {
					for dy in neighbors {
						if dx == 0 && dy == 0 {
							continue
						}
						x, y := i + dx, j + dy
						if x >= 0 && x < lines.len && y >= 0 && y < line.len && lines[x][y] == `#` {
							dead++
						}
					}
				}
				if dead == 3 {
					result += '#'
				} else {
					result += '.'
				}
			}
		}
		result += '\n'
	}
	return result.trim_space()
}

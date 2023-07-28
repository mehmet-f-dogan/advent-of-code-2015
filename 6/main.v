import os

struct Instruction {
pub:
	action  string
	start_x int
	start_y int
	end_x   int
	end_y   int
}

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }
	instructions := parse_instructions(input)
	solution_1(instructions)
	solution_2(instructions)
}

fn solution_1(instructions []Instruction) {
	mut grid := [][]bool{len: 1000, init: []bool{len: 1000}}
	for instruction in instructions {
		for i in instruction.start_x .. instruction.end_x + 1 {
			for j in instruction.start_y .. instruction.end_y + 1 {
				grid[i][j] = match instruction.action {
					'toggle' { !grid[i][j] }
					'turn on' { true }
					'turn off' { false }
					else { panic('unknown action') }
				}
			}
		}
	}
	mut lit_count := 0
	for line in grid {
		for lamp in line {
			if lamp {
				lit_count++
			}
		}
	}
	println(lit_count)
}

fn solution_2(instructions []Instruction) {
	mut grid := [][]int{len: 1000, init: []int{len: 1000}}
	for instruction in instructions {
		for i in instruction.start_x .. instruction.end_x + 1 {
			for j in instruction.start_y .. instruction.end_y + 1 {
				grid[i][j] = match instruction.action {
					'toggle' {
						grid[i][j] + 2
					}
					'turn on' {
						grid[i][j] + 1
					}
					'turn off' {
						if grid[i][j] == 0 {
							0
						} else {
							grid[i][j] - 1
						}
					}
					else {
						panic('unknown action')
					}
				}
			}
		}
	}
	mut lit_count := 0
	for line in grid {
		for lamp in line {
			lit_count += lamp
		}
	}
	println(lit_count)
}

fn parse_instructions(data string) []Instruction {
	mut instructions := []Instruction{}
	lines := data.split('\n')
	for line in lines {
		if line == '' {
			continue
		}
		mut parse_line := line
		mut action := ''
		for test_action in ['toggle', 'turn on', 'turn off'] {
			if parse_line.starts_with(test_action) {
				action = test_action
			}
		}
		parse_line = parse_line[action.len + 1..]

		start_str := parse_line.split(' ')[0]
		start_x := start_str.split(',')[0].int()
		start_y := start_str.split(',')[1].int()
		end_str := parse_line.split(' ')[2]
		end_x := end_str.split(',')[0].int()
		end_y := end_str.split(',')[1].int()
		instruction := Instruction{
			action: action
			start_x: start_x
			start_y: start_y
			end_x: end_x
			end_y: end_y
		}
		instructions << instruction
	}
	return instructions
}

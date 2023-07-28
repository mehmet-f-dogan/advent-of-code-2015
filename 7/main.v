import os
import strconv

struct Gate {
pub:
	input1   string
	operator string
	input2   string
	output   string
}

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }
	gates := parse_gates(input)
	mut output_gate_map := map[string]Gate{}
	for gate in gates {
		output_gate_map[gate.output] = gate
	}
	solution_1(output_gate_map)
	solution_2(output_gate_map)
}

fn solution_1(output_gate_map map[string]Gate) {
	mut lookup := &map[string]u16{}
	println(recursive_evaluate(output_gate_map, 'a', mut lookup))
}

fn solution_2(output_gate_map map[string]Gate) {
	mut lookup := map[string]u16{}
	lookup['b'] = 956
	println(recursive_evaluate(output_gate_map, 'a', mut lookup))
}

fn recursive_evaluate(output_gate_map map[string]Gate, value string, mut lookup map[string]u16) u16 {
	if value in lookup {
		return lookup[value]
	}
	evaluation := match output_gate_map[value].operator {
		'' {
			u16(strconv.parse_uint(value, 10, 16) or {
				recursive_evaluate(output_gate_map, output_gate_map[value].input1, mut
					lookup)
			})
		}
		'NOT' {
			65535 - recursive_evaluate(output_gate_map, output_gate_map[value].input1, mut
				lookup)
		}
		'AND' {
			recursive_evaluate(output_gate_map, output_gate_map[value].input1, mut lookup) & recursive_evaluate(output_gate_map,
				output_gate_map[value].input2, mut lookup)
		}
		'OR' {
			recursive_evaluate(output_gate_map, output_gate_map[value].input1, mut lookup) | recursive_evaluate(output_gate_map,
				output_gate_map[value].input2, mut lookup)
		}
		'LSHIFT' {
			shifted := recursive_evaluate(output_gate_map, output_gate_map[value].input1, mut
				lookup)
			shift_amount := strconv.parse_int(output_gate_map[value].input2, 10, 32) or {
				panic('cannot parse lshift amount')
			}
			return shifted << shift_amount
		}
		'RSHIFT' {
			shifted := recursive_evaluate(output_gate_map, output_gate_map[value].input1, mut
				lookup)
			shift_amount := strconv.parse_int(output_gate_map[value].input2, 10, 32) or {
				panic('cannot parse rshift amount')
			}
			return shifted >> shift_amount
		}
		else {
			panic('unknown operation')
		}
	}
	lookup[value] = evaluation
	return evaluation
}

fn parse_gates(data string) []Gate {
	mut gates := []Gate{}
	lines := data.split('\n')
	for line in lines {
		if line == '' {
			continue
		}
		parts := line.split(' ')
		if parts[1] in ['AND', 'OR', 'RSHIFT', 'LSHIFT'] {
			gate := Gate{
				input1: parts[0]
				operator: parts[1]
				input2: parts[2]
				output: parts[4]
			}
			gates << gate
		} else if parts[0] == 'NOT' {
			gate := Gate{
				input1: parts[1]
				operator: parts[0]
				output: parts[3]
			}
			gates << gate
		} else {
			gate := Gate{
				input1: parts[0]
				output: parts[2]
			}
			gates << gate
		}
	}
	return gates
}

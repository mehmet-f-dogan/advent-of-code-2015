import os
import arrays

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }
	lines := input.split('\n')
	numbers := lines.map(fn (line string) []i64 {
		return line.split('x').map(fn (segment string) i64 {
			return segment.parse_int(10, 64) or { panic('cannot parse segment: ${segment}') }
		})
	})
	solution_1(numbers)
	solution_2(numbers)
}

fn solution_1(input [][]i64) {
	mut total_paper := i64(0)
	for _, numbers in input {
		l := numbers[0]
		w := numbers[1]
		h := numbers[2]
		lw := l * w
		lh := l * h
		wh := w * h
		min_area := arrays.min([lw, lh, wh]) or { 0 }
		total_paper += 2 * (lw + lh + wh) + min_area
	}
	println(total_paper)
}

fn solution_2(input [][]i64) {
	mut total_paper := i64(0)
	for _, numbers in input {
		l := numbers[0]
		w := numbers[1]
		h := numbers[2]
		max_side := arrays.max([l, w, h]) or { 0 }
		total_sides := l + w + h
		wrap := (total_sides - max_side) * 2
		ribbon := l * w * h
		total_paper += wrap + ribbon
	}
	println(total_paper)
}

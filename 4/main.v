import math
import crypto.md5

fn main() {
	input := 'INPUT'
	solution_1(input)
	solution_2(input)
}

fn solution_1(input string) {
	for i := 0; i < math.max_f64; i++ {
		hash := md5.hexhash(input + i.str())
		if hash.substr(0, 5) == '00000' {
			println(i)
			break
		}
	}
}

fn solution_2(input string) {
	for i := 0; i < math.max_f64; i++ {
		hash := md5.hexhash(input + i.str())
		if hash.substr(0, 6) == '000000' {
			println(i)
			break
		}
	}
}

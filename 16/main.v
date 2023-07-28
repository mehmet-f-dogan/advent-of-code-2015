import os

struct Record {
pub mut:
	sue_num     int = -1
	children    int = -1
	cats        int = -1
	samoyeds    int = -1
	pomeranians int = -1
	akitas      int = -1
	vizslas     int = -1
	goldfish    int = -1
	trees       int = -1
	cars        int = -1
	perfumes    int = -1
}

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }

	records := parse_input(input)

	solution_1(records)
	solution_2(records)

}


fn solution_1(records []Record){
	base_record := Record{
		children: 3
		cats: 7
		samoyeds: 2
		pomeranians: 0
		akitas: 0
		vizslas: 0
		goldfish: 5
		trees: 3
		cars: 2
		perfumes: 1
	}

	filter := fn(record Record, base_record Record) bool {
		if record.children > -1 {
			if record.children != base_record.children {
				return false
			}
		}
		if record.cats > -1 {
			if record.cats != base_record.cats {
				return false
			}
		}
		if record.samoyeds > -1 {
			if record.samoyeds != base_record.samoyeds {
				return false
			}
		}
		if record.pomeranians > -1 {
			if record.pomeranians != base_record.pomeranians {
				return false
			}
		}
		if record.akitas > -1 {
			if record.akitas != base_record.akitas {
				return false
			}
		}
		if record.vizslas > -1 {
			if record.vizslas != base_record.vizslas {
				return false
			}
		}
		if record.goldfish > -1 {
			if record.goldfish != base_record.goldfish {
				return false
			}
		}
		if record.trees > -1 {
			if record.trees != base_record.trees {
				return false
			}
		}
		if record.cars > -1 {
			if record.cars != base_record.cars {
				return false
			}
		}
		if record.perfumes > -1 {
			if record.perfumes != base_record.perfumes {
				return false
			}
		}
		return true
	}
	filtered_records := records.filter(filter(it, base_record))
	println(filtered_records)
}

fn solution_2(records []Record){
	base_record := Record{
		children: 3
		cats: 7
		samoyeds: 2
		pomeranians: 0
		akitas: 0
		vizslas: 0
		goldfish: 5
		trees: 3
		cars: 2
		perfumes: 1
	}

	filter := fn(record Record, base_record Record) bool {
		if record.children > -1 {
			if record.children != base_record.children {
				return false
			}
		}
		if record.cats > -1 {
			if record.cats <= base_record.cats {
				return false
			}
		}
		if record.samoyeds > -1 {
			if record.samoyeds != base_record.samoyeds {
				return false
			}
		}
		if record.pomeranians > -1 {
			if record.pomeranians >= base_record.pomeranians {
				return false
			}
		}
		if record.akitas > -1 {
			if record.akitas != base_record.akitas {
				return false
			}
		}
		if record.vizslas > -1 {
			if record.vizslas != base_record.vizslas {
				return false
			}
		}
		if record.goldfish > -1 {
			if record.goldfish >= base_record.goldfish {
				return false
			}
		}
		if record.trees > -1 {
			if record.trees <= base_record.trees {
				return false
			}
		}
		if record.cars > -1 {
			if record.cars != base_record.cars {
				return false
			}
		}
		if record.perfumes > -1 {
			if record.perfumes != base_record.perfumes {
				return false
			}
		}
		return true
	}
	filtered_records := records.filter(filter(it, base_record))
	println(filtered_records)
}

fn parse_input(input string) []Record {
	// Split the input by lines to process each Sue's information
	lines := input.trim_space().split('\n')

	// Initialize an empty list to store Sue instances
	mut sues := []Record{}

	// Iterate over each line and extract Sue's information
	for line in lines {
		sue_info := line.trim_space().split(' ')
		sue_num := sue_info[1].trim(':').int()

		// Initialize a new Sue instance with default values for each characteristic
		mut sue := Record{
			sue_num: sue_num
		}

		// Iterate over the remaining information and set the corresponding characteristic values
		for i := 2; i < sue_info.len; i += 2 {
			characteristic := sue_info[i].trim(',')
			value := sue_info[i + 1].trim(',')

			match characteristic {
				'children:' { sue.children = value.int() }
				'cats:' { sue.cats = value.int() }
				'samoyeds:' { sue.samoyeds = value.int() }
				'pomeranians:' { sue.pomeranians = value.int() }
				'akitas:' { sue.akitas = value.int() }
				'vizslas:' { sue.vizslas = value.int() }
				'goldfish:' { sue.goldfish = value.int() }
				'trees:' { sue.trees = value.int() }
				'cars:' { sue.cars = value.int() }
				'perfumes:' { sue.perfumes = value.int() }
				else {}
			}
		}

		// Add the Sue instance to the list
		sues << sue
	}

	return sues
}

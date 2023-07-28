import os

struct Record {
pub:
	name           string
	speed          int
	run_duration   int
	total_duration int
pub mut:
	distance int
	points   int
}

fn main() {
	input := os.read_file('./input.txt') or { panic('cannot read input file') }
	records := extract_records(input)
	solution_1(records)
	solution_2(records)
}

fn solution_1(records []Record) {
	mut records_clone := clone_records(records)
	for i := 0; i < 2503; i++ {
		solution_1_process_second(mut records_clone, i)
	}
	records_clone.sort_with_compare(fn (a &Record, b &Record) int {
		return a.distance - b.distance
	})
	println(records_clone[records_clone.len - 1].distance)
}

fn solution_2(records []Record) {
	mut records_clone := clone_records(records)
	for i := 0; i < 2503; i++ {
		solution_2_process_second(mut records_clone, i)
	}
	records_clone.sort_with_compare(fn (a &Record, b &Record) int {
		return a.points - b.points
	})
	println(records_clone[records_clone.len - 1].points)
}

fn solution_1_process_second(mut records []Record, second int) {
	for record_index, record in records {
		if second % record.total_duration < record.run_duration {
			records[record_index].distance += record.speed
		}
	}
}

fn solution_2_process_second(mut records []Record, second int) {
	mut leader_distance := 0
	mut leader_indices := []int{}
	for record_index, record in records {
		if second % record.total_duration < record.run_duration {
			records[record_index].distance += record.speed
		}
		if records[record_index].distance > leader_distance {
			leader_distance = records[record_index].distance
			leader_indices.clear()
		}
		if records[record_index].distance == leader_distance {
			leader_indices << record_index
		}
	}
	for leader_index in leader_indices {
		records[leader_index].points++
	}
}

fn clone_records(records []Record) []Record {
	mut records_clone := []Record{}
	for record in records {
		records_clone << Record{
			name: record.name
			speed: record.speed
			run_duration: record.run_duration
			total_duration: record.total_duration
			distance: 0
			points: 0
		}
	}
	return records_clone
}

fn extract_records(input string) []Record {
	mut records := []Record{}
	lines := input.split('\n')
	for line in lines {
		if line == '' {
			continue
		}
		tokens := line.split(' ')
		name := tokens[0]
		speed := tokens[3].int()
		run := tokens[6].int()
		rest := tokens[13].int()
		records << Record{
			name: name
			speed: speed
			run_duration: run
			total_duration: run + rest
			distance: 0
			points: 0
		}
	}
	return records
}

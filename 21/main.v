import arrays

struct Item {
pub:
	cost   int
	damage int
	armor  int
}

fn main() {
	weapons := [
		Item{
			cost: 8
			damage: 4
			armor: 0
		},
		Item{
			cost: 10
			damage: 5
			armor: 0
		},
		Item{
			cost: 25
			damage: 6
			armor: 0
		},
		Item{
			cost: 40
			damage: 7
			armor: 0
		},
		Item{
			cost: 74
			damage: 8
			armor: 0
		},
	]
	armors := [
		Item{
			cost: 13
			damage: 0
			armor: 1
		},
		Item{
			cost: 31
			damage: 0
			armor: 2
		},
		Item{
			cost: 53
			damage: 0
			armor: 3
		},
		Item{
			cost: 75
			damage: 0
			armor: 4
		},
		Item{
			cost: 102
			damage: 0
			armor: 5
		},
	]
	rings := [
		Item{
			cost: 25
			damage: 1
			armor: 0
		},
		Item{
			cost: 50
			damage: 2
			armor: 0
		},
		Item{
			cost: 100
			damage: 3
			armor: 0
		},
		Item{
			cost: 20
			damage: 0
			armor: 1
		},
		Item{
			cost: 40
			damage: 0
			armor: 2
		},
		Item{
			cost: 80
			damage: 0
			armor: 3
		},
	]
	configurations := generate_all_configurations(weapons, armors, rings)
	solution_1(configurations)
	solution_2(configurations)
}

fn solution_1(configurations [][]Item) {
	mut winning_costs := []int{}
	for configuration in configurations {
		if can_player_win(configuration) {
			mut total_cost := 0
			for item in configuration {
				total_cost += item.cost
			}
			winning_costs << total_cost
		}
	}
	min_cost := arrays.min(winning_costs) or { panic('never') }
	println(min_cost)
}

fn solution_2(configurations [][]Item) {
	mut losing_costs := []int{}
	for configuration in configurations {
		if !can_player_win(configuration) {
			mut total_cost := 0
			for item in configuration {
				total_cost += item.cost
			}
			losing_costs << total_cost
		}
	}
	max_cost := arrays.max(losing_costs) or { panic('never') }
	println(max_cost)
}

fn generate_all_configurations(weapons []Item, armors []Item, rings []Item) [][]Item {
	mut configurations := [][]Item{}
	weapon_configurations := generate_weapon_configurations(weapons)
	armor_configurations := generate_armor_configurations(armors)
	ring_configurations := generate_ring_configurations(rings)
	for weapon_configuration in weapon_configurations {
		for armor_configuration in armor_configurations {
			for ring_configuration in ring_configurations {
				mut configuration := []Item{}
				for weapon in weapon_configuration {
					configuration << weapon
				}
				for armor in armor_configuration {
					configuration << armor
				}
				for ring in ring_configuration {
					configuration << ring
				}
				configurations << configuration
			}
		}
	}

	return configurations
}

fn generate_weapon_configurations(weapons []Item) [][]Item {
	mut final_configurations := [][]Item{}
	for weapon in weapons {
		final_configurations << [weapon]
	}

	return final_configurations
}

fn generate_armor_configurations(armors []Item) [][]Item {
	mut final_configurations := [][]Item{}
	for armor in armors {
		final_configurations << [armor]
	}
	final_configurations << []Item{}

	return final_configurations
}

fn generate_ring_configurations(rings []Item) [][]Item {
	mut final_configurations := [][]Item{}
	for ring_index_0 := 0; ring_index_0 < rings.len; ring_index_0++ {
		for ring_index_1 := (ring_index_0 + 1); ring_index_1 < rings.len; ring_index_1++ {
			final_configurations << [rings[ring_index_0], rings[ring_index_1]]
		}
	}
	for ring in rings {
		final_configurations << [ring]
	}
	final_configurations << []Item{}

	return final_configurations
}

fn can_player_win(items []Item) bool {
	mut boss_hp := 104
	boss_damage := 8
	boss_armor := 1

	mut player_hp := 100
	mut player_damage := 0
	mut player_armor := 0

	for item in items {
		player_damage += item.damage
		player_armor += item.armor
	}

	for move in 1 .. 200 {
		if boss_hp <= 0 {
			return true
		} else if player_hp <= 0 {
			return false
		}
		if move % 2 == 1 {
			mut to_boss_damage := player_damage - boss_armor
			if to_boss_damage < 1 {
				to_boss_damage = 1
			}
			boss_hp -= to_boss_damage
		} else {
			mut to_player_damage := boss_damage - player_armor
			if to_player_damage < 1 {
				to_player_damage = 1
			}
			player_hp -= to_player_damage
		}
	}

	return true
}

/// @description
#region enumss
enum good_cards {
	more_swords,
	bigger_swords,
	laser_sword,
	teleport_dash,
	more_health,
	heal_overtime,
	life_leach,
	bomb_slice,
	shield,
	more_damage,
	thorns,
	size,
}

enum bad_cards  {
	buzz_saws,
	turrets,
	wall_spikes,
	enemy_health,
	enemy_damage,
	size,
}

enum card { 
	good,
	bad
}
#endregion

#region dataa
stacks[card.good][good_cards.more_swords  ]	= true ;
stacks[card.good][good_cards.bigger_swords]	= true ;
stacks[card.good][good_cards.laser_sword  ]	= true ;
stacks[card.good][good_cards.teleport_dash]	= false;
stacks[card.good][good_cards.more_health  ]	= true ;
stacks[card.good][good_cards.heal_overtime]	= true ;
stacks[card.good][good_cards.life_leach	  ]	= true ;
stacks[card.good][good_cards.bomb_slice	  ]	= true ;
stacks[card.good][good_cards.shield		  ]	= true ;
stacks[card.good][good_cards.more_damage  ]	= true ;
stacks[card.good][good_cards.thorns		  ]	= true ;

stacks[card.bad ][bad_cards.buzz_saws	  ] = true ;
stacks[card.bad ][bad_cards.turrets		  ] = true ;
stacks[card.bad ][bad_cards.wall_spikes	  ] = true ;
stacks[card.bad ][bad_cards.enemy_health  ] = true ;
stacks[card.bad ][bad_cards.enemy_damage  ] = true ;

counts[card.good][good_cards.more_swords  ]	= 0;
counts[card.good][good_cards.bigger_swords]	= 0;
counts[card.good][good_cards.laser_sword  ]	= 0;
counts[card.good][good_cards.teleport_dash]	= 0;
counts[card.good][good_cards.more_health  ]	= 0;
counts[card.good][good_cards.heal_overtime]	= 0;
counts[card.good][good_cards.life_leach	  ]	= 0;
counts[card.good][good_cards.bomb_slice	  ]	= 0;
counts[card.good][good_cards.shield		  ]	= 0;
counts[card.good][good_cards.more_damage  ]	= 0;
counts[card.good][good_cards.thorns		  ]	= 0;
counts[card.bad ][bad_cards.buzz_saws	  ] = 0;
counts[card.bad ][bad_cards.turrets		  ] = 0;
counts[card.bad ][bad_cards.wall_spikes	  ] = 0;
counts[card.bad ][bad_cards.enemy_health  ] = 0;
counts[card.bad ][bad_cards.enemy_damage  ] = 0;
#endregion

function generate_card_list(type, number_of_cards) {
	var list = ds_list_create();
	
	var index = 0;
	for (var i = 0; i <	number_of_cards; i++) {
		if (type == card.good) {
		do {
			index = irandom(good_cards.size-1);
		} until !(stacks[card.good][index] and counts[card.good][index] > 0);
		} else {
		do {
			index = irandom(bad_cards.size-1);
		} until !(stacks[card.bad][index] and counts[card.bad][index] > 0);
		}
		
		ds_list_add(list, index);
	}
}
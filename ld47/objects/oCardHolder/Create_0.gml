/// @description
#region enumss
enum good_cards {
	more_swords, // done
	bigger_swords, //done 
	laser_sword, 
	teleport_dash, //done
	more_health, //done
	heal_overtime, //done 
	life_leach, //done
	bomb_slice, // done
	shield, // done
	more_damage, //done
	thorns, //done
	size,
}

enum bad_cards  {
	buzz_saws, // done
	turrets,
	wall_spikes,
	enemy_health, //done
	enemy_damage, // done
	laser_turrets,
	enemy_faster, // done
	enemy_attack_more, // done
	enemy_leech, // done
	glass_bones, // done
	size,
}

enum card { 
	good,
	bad
}
#endregion

#region data
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

stacks[card.bad ][bad_cards.buzz_saws		 ] = true ;
stacks[card.bad ][bad_cards.turrets			 ] = false;
stacks[card.bad ][bad_cards.wall_spikes		 ] = true ;
stacks[card.bad ][bad_cards.enemy_health	 ] = true ;
stacks[card.bad ][bad_cards.enemy_damage 	 ] = true ;
stacks[card.bad ][bad_cards.laser_turrets	 ] = false;
stacks[card.bad ][bad_cards.enemy_faster	 ] = true ;
stacks[card.bad ][bad_cards.enemy_attack_more] = true ;
stacks[card.bad ][bad_cards.enemy_leech	 ] = true ;
stacks[card.bad ][bad_cards.glass_bones		 ] = true ;


counts[card.good][good_cards.more_swords	 ] = 1;
counts[card.good][good_cards.bigger_swords	 ] = 0;
counts[card.good][good_cards.laser_sword	 ] = 0;
counts[card.good][good_cards.teleport_dash	 ] = 0;
counts[card.good][good_cards.more_health	 ] = 0;
counts[card.good][good_cards.heal_overtime	 ] = 0;
counts[card.good][good_cards.life_leach		 ] = 0;
counts[card.good][good_cards.bomb_slice		 ] = 0;
counts[card.good][good_cards.shield			 ] = 0;
counts[card.good][good_cards.more_damage	 ] = 0;
counts[card.good][good_cards.thorns			 ] = 0;

counts[card.bad ][bad_cards.buzz_saws		 ] = 2;
counts[card.bad ][bad_cards.turrets			 ] = 0;
counts[card.bad ][bad_cards.wall_spikes		 ] = 0;
counts[card.bad ][bad_cards.enemy_health	 ] = 0;
counts[card.bad ][bad_cards.enemy_damage 	 ] = 0;
counts[card.bad ][bad_cards.laser_turrets	 ] = 0;
counts[card.bad ][bad_cards.enemy_faster	 ] = 0;
counts[card.bad ][bad_cards.enemy_attack_more] = 0;
counts[card.bad ][bad_cards.enemy_leech		 ] = 0;
counts[card.bad ][bad_cards.glass_bones		 ] = 0;
#endregion

function generate_card_list(type, number_of_cards) {
	var list = ds_list_create();
	
	var temp_counts;
	temp_counts[card.good][good_cards.more_swords		] = counts[card.good][good_cards.more_swords	 ] ;
	temp_counts[card.good][good_cards.bigger_swords		] = counts[card.good][good_cards.bigger_swords	 ] ;
	temp_counts[card.good][good_cards.laser_sword		] = counts[card.good][good_cards.laser_sword	 ] ;
	temp_counts[card.good][good_cards.teleport_dash		] = counts[card.good][good_cards.teleport_dash	 ] ;
	temp_counts[card.good][good_cards.more_health		] = counts[card.good][good_cards.more_health	 ] ;
	temp_counts[card.good][good_cards.heal_overtime		] = counts[card.good][good_cards.heal_overtime	 ] ;
	temp_counts[card.good][good_cards.life_leach		 ] = counts[card.good][good_cards.life_leach	]	;
	temp_counts[card.good][good_cards.bomb_slice		 ] = counts[card.good][good_cards.bomb_slice	]	;
	temp_counts[card.good][good_cards.shield			 ] = counts[card.good][good_cards.shield		]	;
	temp_counts[card.good][good_cards.more_damage		] = counts[card.good][good_cards.more_damage	 ] ;
	temp_counts[card.good][good_cards.thorns			 ] = counts[card.good][good_cards.thorns		]	;
	temp_counts[card.bad ][bad_cards.buzz_saws			 ] = counts[card.bad ][bad_cards.buzz_saws		 ] ;
	temp_counts[card.bad ][bad_cards.turrets			 ] = counts[card.bad ][bad_cards.turrets		]	;
	temp_counts[card.bad ][bad_cards.wall_spikes		 ] = counts[card.bad ][bad_cards.wall_spikes	]	;
	temp_counts[card.bad ][bad_cards.enemy_health		] = counts[card.bad ][bad_cards.enemy_health	 ] ;
	temp_counts[card.bad ][bad_cards.enemy_damage 		] = counts[card.bad ][bad_cards.enemy_damage 	 ] ;
	temp_counts[card.bad ][bad_cards.laser_turrets		] = counts[card.bad ][bad_cards.laser_turrets	 ] ;
	temp_counts[card.bad ][bad_cards.enemy_faster		] = counts[card.bad ][bad_cards.enemy_faster	 ] ;
	temp_counts[card.bad ][bad_cards.enemy_attack_more] = counts[card.bad ][bad_cards.enemy_attack_more];
	temp_counts[card.bad ][bad_cards.enemy_leech		] = counts[card.bad ][bad_cards.enemy_leech	];
	temp_counts[card.bad ][bad_cards.glass_bones		] = counts[card.bad ][bad_cards.glass_bones		];
	
	var index = 0;
	for (var i = 0; i <	number_of_cards; i++) {
		if (type == card.good) {
		do {
			index = irandom(good_cards.size-1);
			// this part below is to make sure we dont make duplicates of cards that cant stack
		} until !(stacks[card.good][index] == false and temp_counts[card.good][index] > 0);
		
		temp_counts[card.good][index]++;
		} else {
		do {
			index = irandom(bad_cards.size-1);
			
		} until !(stacks[card.bad][index] == false and temp_counts[card.bad][index] > 0);
		
		temp_counts[card.bad][index]++;
		}
		
		ds_list_add(list, index);
	}
	
	return list;
}

function count_cards(type) {
	var count = 0;
	if type == card.good {
		for (var i = 0; i <	good_cards.size; i++) {
			count += counts[type][i];
		}
	} else {
		for (var i = 0; i <	 bad_cards.size; i++) {
				count += counts[type][i];	
		}
	}
	
	return count;
}

room_goto(Room1);
//instance_create_layer(room_width/2, room_height/2, layer, oPlayer);
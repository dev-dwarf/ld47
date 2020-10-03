/// @description

enum wave_states {
	spawn,
	battle, 
	next
}

state = wave_states.spawn;

spawn_timer = 60;

no_of_enemies  = oCardHolder.count_cards(card.bad) + 1;

var enemy_list = ds_list_create();
ds_list_add(enemy_list, oBurstingBrian,	
						oChargingCharlie,
						oChasingChuck,
						oProjectilePaul,
						oShotgunShitley);
						
var enemy_counts; var average_enemy_count = 0;

enemy_counts[oBurstingBrian		] = 0;
enemy_counts[oChargingCharlie	] = 0;
enemy_counts[oChasingChuck		] = 0;
enemy_counts[oProjectilePaul	] = 0;
enemy_counts[oShotgunShitley	] = 0;

//log(string(enemy_list[| 0]));
instance_create_layer(room_width/2, room_height/2, layer, oPlayer);

#region create all the shit
for (var i = 0; i < no_of_enemies; i++) {
	//do {
		ds_list_shuffle(enemy_list);
		var type = enemy_list[| 0];
		//log(string(type));
	//}
	//until (enemy_counts[type] <= average_enemy_count+2);
	
	var angle = i * 360/no_of_enemies + 0.5 * random_range(-0.5*360/no_of_enemies,0.5*360/no_of_enemies);
	var radius = random_range(80, 120);
	
	with instance_create_layer(room_width/2 + lengthdir_x(radius, angle),
						  room_height/2 + lengthdir_y(radius, angle),
						  layer,
						  oSpawnSpot) {
		object_to_spawn = type;					  
	}
	
	average_enemy_count = 0;
	for (var j = 0; j < ds_list_size(enemy_list); j++) {
		average_enemy_count += enemy_counts[enemy_list[| j]];
	}
	average_enemy_count /= ds_list_size(enemy_list);
}




ds_list_destroy(enemy_list);
#endregion
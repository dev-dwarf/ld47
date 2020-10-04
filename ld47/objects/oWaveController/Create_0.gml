/// @description

enum wave_states {
	spawn,
	battle, 
	next
}

state = wave_states.spawn;

spawn_time = 90;
spawn_timer = spawn_time;

no_of_enemies  = max(1, oCardHolder.count_cards(card.bad));
max_enemies_per_wave = 5;

wave_number = ceil(no_of_enemies/max_enemies_per_wave);
max_wave_number = wave_number;

global.wave_count++;

//log(string(enemy_list[| 0]));
instance_create_layer(room_width/2, room_height/2, layer, oPlayer);

function create_wave() {
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
	
	#region create all the shit
	var nnn = min(no_of_enemies,max_enemies_per_wave);
	for (var i = 0; i < nnn; i++) {
		//do {
			ds_list_shuffle(enemy_list);
			var type = enemy_list[| 0];
			//log(string(type));
		//}
		//until (enemy_counts[type] <= average_enemy_count+2);
	
		var angle = i * 360/nnn + 0.5 * random_range(-0.5*360/nnn,0.5*360/nnn);
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

	wave_number--;
	no_of_enemies -= max_enemies_per_wave;

	

	ds_list_destroy(enemy_list);
	#endregion
}

for (var i = 0; i < oCardHolder.counts[card.bad][bad_cards.buzz_saws];i++) {
	var xx = irandom(100);
	if (chance(50)) xx = room_width-xx;
	var yy = irandom(room_height);
		
	instance_create_layer(xx,yy,layer,oBuzzSaw);
}

for (var i = 0; i < oCardHolder.counts[card.bad][bad_cards.wall_spikes];i++) {
	var xx = irandom_range(2,5)*choose(-1,1);
	var yy = irandom_range(2,5)*choose(-1,1);
	
	xx = room_width /2 + 24 * xx;
	yy = 12 + room_height/2 + 24 * yy;
		
	instance_create_layer(xx,yy,layer,oSpikes);
}
	
create_wave();
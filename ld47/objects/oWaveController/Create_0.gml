/// @description

enum wave_states {
	spawn,
	battle, 
	next
}

state = wave_states.spawn;

spawn_time = 90;
spawn_timer = spawn_time;

no_of_enemies  = 1//max(1, oCardHolder.count_cards(card.bad));
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

make_gear_list = function() {
	var gear_list = ds_list_create();
	var cam_x = camera_get_view_x(view_camera[0]);
	var cam_y = camera_get_view_y(view_camera[0]);

	for (var i = 0; i < instance_number(oTopGear);i++) {
		var inst =  instance_find(oTopGear, i)
		
		if (inst.x >= cam_x and inst.x <= cam_x+DEFAULT_WIDTH ) and
		   (inst.y >= cam_y and inst.y <= cam_x+DEFAULT_HEIGHT) {
			ds_list_add(gear_list, inst);
		}
	}
	return gear_list;
}

var gear_list = make_gear_list();

for (var i = 0; i < oCardHolder.counts[card.bad][bad_cards.turrets];i++) {
	var index = irandom(ds_list_size(gear_list)-1);
	var inst = gear_list[| index]
	ds_list_delete(gear_list, index);
	
	if (ds_list_size(gear_list) == 0) {
		ds_list_destroy(gear_list);
		gear_list = make_gear_list();
	}
		
	instance_create_layer(inst.x,inst.y,layer,oTurret);
}

for (var i = 0; i < oCardHolder.counts[card.bad][bad_cards.laser_turrets];i++) {
	var index = irandom(ds_list_size(gear_list)-1);
	var inst = gear_list[| index]
	ds_list_delete(gear_list, index);
	
	if (ds_list_size(gear_list) == 0) {
		ds_list_destroy(gear_list);
		gear_list = make_gear_list();
	}
		
	instance_create_layer(inst.x,inst.y,layer,oLaserTurret);
}
	
create_wave();
/// @description


// TODO basic sound
// TODO enemy generation
	// pick from presets?
	
	// TODO: fullscreen mode
	
// TODO enemy types



event_inherited();

player_active = true;//can player object receive control input?

enum player_states {
	idle,
	walk,
	dash,
	freeze,
	death,
}

global.sword_id = 0;
global.sword_count = oCardHolder.counts[card.good][good_cards.more_swords  ];
sword_size = 0.75 + 0.15*power(oCardHolder.counts[card.good][good_cards.bigger_swords], 0.5);

has_laser = (oCardHolder.counts[card.good][good_cards.laser_sword]>0);
laser_regen_speed = 0.003 + 0.002 *power(oCardHolder.counts[card.good][good_cards.laser_sword], 0.4);
laser_available = 1.0;

can_attack = false;
state = player_states.idle;

enum dash_states {
	start, 
	mid, 
	recover
}

has_shield = oCardHolder.counts[card.good][good_cards.shield] > 0;
shield_regen_speed = 0.003 * power(oCardHolder.counts[card.good][good_cards.shield], 0.5)
hit_damage = (1 + power(global.sword_count, 0.5) * 0.3 + 0.2 * power(oCardHolder.counts[card.good][good_cards.bigger_swords], 0.5)) * power(1.1, oCardHolder.counts[card.good][good_cards.more_damage]);
max_hp = 5 + 2.5 * oCardHolder.counts[card.good][good_cards.more_health  ];
dash_is_teleport = oCardHolder.counts[card.good][good_cards.teleport_dash];

leach = 0.1*power(oCardHolder.counts[card.good][good_cards.life_leach  ], 0.75);
thorns = 0.3*power(oCardHolder.counts[card.good][good_cards.thorns  ], 0.6);
heal_overtime = 0.0007*power(oCardHolder.counts[card.good][good_cards.heal_overtime  ],0.5);

shield_regen = 0;
shield_radius = 24;

i_frames = 0;

dash_not_ready = 0;
dash_recharge = 13;

if (dash_is_teleport) {
	dash_start_frames = 2;
	dash_frames = 3;
	dash_recovery_frames = 7;
} else {
	dash_start_frames = 3;
	dash_frames = 5;
	dash_recovery_frames = 7;
}

knockback = 0;
knockback_dir = 0;

dash_start_x = x;
dash_start_y = y;
dash_state = dash_states.start;
dash_distance = 58;
dash_frame_count = dash_start_frames;


hp = max_hp;

made_footstep = false;
made_eyeflap = false;

consecutive_sword_hits = 0;
hits_this_time = 0;

move_direction = 0;
move_direction_speed = 0.5; 

move_speed = 0;
move_speed_max = 1.8;
move_accel = 0.07;
move_decel = 0.2;

draw_scale = 1.0;



dust = part_system_create();
dust_particles = part_type_create();
part_type_sprite(dust_particles, sPlayerDust, 1, 1, false);
part_type_size(dust_particles, 0.8, 1.1, -0.06, 0);
part_type_life(dust_particles, 30, 50);
part_type_speed(dust_particles, 1.5, 1.75, -0.12, 0.0);
part_type_direction(dust_particles, 80, 100, 0, 5);

sword_dust = part_type_create();
part_type_sprite(sword_dust, sSwordDust, 1, 1, false);
part_type_size(sword_dust, 0.8, 1.1, -0.01, 0);
part_type_life(sword_dust, 10, 15);
part_type_speed(sword_dust, 0.5, 0.75, 0.12, 0.0);
part_type_direction(sword_dust, 80, 100, 0, 5);
part_type_orientation(sword_dust, 0, 0, 0, 0, true);

make_dust = function(xx, yy, count, range) {
	repeat(count) {
		var _xx = xx + random_range(-range, range);
		var _yy = yy + random_range(-range, range);	
	
		part_particles_create(dust, _xx, _yy, dust_particles, 1)
	}
}

hurt_line = function(x1, y1, x2, y2) {
	var list = ds_list_create();
	collision_line_list(x1, y1, x2, y2, pEnemy, true, true, list, true);
				
	for (var i = 0; i < ds_list_size(list); i ++) {
		var inst = list[| i];
		
		inst.hp -= hit_damage*0.5;
		inst.i_frames = 10;
		oCamera.set_shake(0.2);
		
		oPlayer.hits_this_time++;
		play_sound(sndSwordHit, 0, false, 1.0 + 0.075 * oPlayer.consecutive_sword_hits, 0.02, 1.0);
		
		if leach > 0 {
			hp += leach*hit_damage;	
		}			
	}
				
	ds_list_destroy(list);
}

reset_cards = function() {
	instance_destroy(oCardHolder);
	instance_create_layer(0,0,layer,oCardHolder);
	global.wave_count = 0;
}

alarm[0]=1;
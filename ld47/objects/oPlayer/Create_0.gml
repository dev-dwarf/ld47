/// @description

//TODO: depths sort
//TODO: enemies
//TODO: levels
//TODO: cards
// TODO: sword slash flash
// TODO: hit particles

enum player_states {
	idle,
	walk,
	dash,
	freeze
}

global.sword_id = 0;
global.sword_count = oCardHolder.counts[card.good][good_cards.more_swords  ];
sword_size = 1 + 0.1*oCardHolder.counts[card.good][good_cards.bigger_swords];

can_attack = false;
state = player_states.idle;

enum dash_states {
	start, 
	mid, 
	recover
}

i_frames = 0;

dash_not_ready = 0;
dash_recharge = 10;
dash_is_teleport = oCardHolder.counts[card.good][good_cards.teleport_dash];

dash_state = dash_states.start;
dash_start_frames = 3;
dash_frames = 5;
dash_recovery_frames = 2;
dash_distance = 70;
dash_frame_count = dash_start_frames;

hit_damage = (1 + 0.2 * oCardHolder.counts[card.good][good_cards.bigger_swords]) * (1 + oCardHolder.counts[card.good][good_cards.more_damage]);
hp = 3 + oCardHolder.counts[card.good][good_cards.more_health  ];

made_footstep = false;
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
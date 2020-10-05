/// @description

// Inherit the parent event
event_inherited();

draw_flip = 1;

enum boss_states {
	spawn,
	charger,
	avoid,
	burst,
	dead,
	transform,
}

enum boss_sub_states {
	target,
	attack,
	recover,
}

state = boss_states.spawn;
sub_state = boss_sub_states.target;

spawn_delay = 60;
i_frames = 0;

hp = 50 * (1 + 0.01 * oCardHolder.counts[card.bad ][bad_cards.enemy_health]);
hpMax = hp;

charge_count = 3; // how many charges he does before going to next states
charge_time = 60/(1 + 0.05 * oCardHolder.counts[card.bad ][bad_cards.enemy_attack_more]);
charge_speed = 9*(1 + 0.1 * oCardHolder.counts[card.bad ][bad_cards.enemy_faster]);

avoid_count = 3;
avoid_shoot_time = 1.85*60/(1 + 0.05 * oCardHolder.counts[card.bad ][bad_cards.enemy_attack_more]); // time between shots, rn 1 1/2 seconds
avoid_speed = 1.2*(1 + 0.1 * oCardHolder.counts[card.bad ][bad_cards.enemy_faster]);

avoid_range = 70;
avoid_spread = 20;
avoid_pellets = 4;
avoid_gone_to_center = false;

burst_shoot_count = 4;
burst_shoot_time = 0.75*60/(1 + 0.05 * oCardHolder.counts[card.bad ][bad_cards.enemy_attack_more]);
projectile_number = 10;
after_burst_recovery_time = 1.00*60/(1 + 0.05 * oCardHolder.counts[card.bad ][bad_cards.enemy_attack_more]);

hit_damage = 1.5 + 0.01 * oCardHolder.counts[card.bad ][bad_cards.enemy_damage  ];

spawn_timer = spawn_delay;
move_speed = 0;
move_direction = 0;
shoot_direction = 0;
charges = charge_count;
charge_timer = charge_time;
avoid_shoot_timer = avoid_shoot_time;
burst_shoot_timer = burst_shoot_time;
after_burst_recovery_timer = after_burst_recovery_time

min_transition_time = 20;
transition_timer = min_transition_time;

draw_scale = 1.0;

next_state = 0;
new_dir = 0;


hit_player = function() {
	oPlayer.i_frames = 60;

	if (oPlayer.has_shield) {
		oPlayer.has_shield = false;
		oPlayer.shield_radius = 32;
	} else {
		oPlayer.hp -= hit_damage*(1+0.5*oCardHolder.counts[card.bad][bad_cards.glass_bones]);
			play_sound(sndPlayerHurt, 0, false, 1.0, 0.04, 1.0);

	
		oCamera.set_shake( 0.5);
	
		oPlayer.knockback = 10;
		oPlayer.knockback_dir = point_direction(x,y,oPlayer.x, oPlayer.y);
	
		if (oPlayer.thorns) {
			hp -= hit_damage * power(1 + 0.3 * oPlayer.thorns, 2);	
		}
		
		if (oCardHolder.counts[card.bad ][bad_cards.enemy_leech	 ] > 0) {
			hp += hit_damage * oCardHolder.counts[card.bad ][bad_cards.enemy_leech	 ] * 0.5;
		}
	}
	
	oCamera.set_shake(0.65);
}
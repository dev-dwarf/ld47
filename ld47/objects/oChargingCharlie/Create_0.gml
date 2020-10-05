/// @description

// Inherit the parent event
event_inherited();

bits_index = sChargingCharlieBits;
draw_angle = 0;

idle_time = 1.5*60/(1 + 0.05 * oCardHolder.counts[card.bad ][bad_cards.enemy_attack_more]); // time between shots, rn 1 1/2 seconds
idle_timer = irandom_range(idle_time/2, idle_time);

hp = 3;

attack_direction = 0;
dash_speed = 12*(1 + 0.1 * oCardHolder.counts[card.bad ][bad_cards.enemy_faster]);
attack_speed = 0;

new_dir = choose(0, 180);

draw_scale = 1.0;
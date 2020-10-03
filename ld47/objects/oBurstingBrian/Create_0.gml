/// @description

// Inherit the parent event
event_inherited();

idle_time = 3.0*60/(1 + 0.05 * oCardHolder.counts[card.bad ][bad_cards.enemy_attack_more]); ; // time between shots, rn 1 1/2 seconds
idle_timer = irandom_range(idle_time/2, idle_time);

projectile_number = 8;

hp = 5;

attack_time = 10;
attack_timer = attack_time;
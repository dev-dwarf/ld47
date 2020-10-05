/// @description

// Inherit the parent event
event_inherited();
draw_flip = 1;

y_off = 0;

idle_time = 1.5*60/(1 + 0.05 * oCardHolder.counts[card.bad ][bad_cards.enemy_attack_more]); ; // time between shots, rn 1 1/2 seconds
idle_timer = irandom_range(idle_time/2, idle_time);

hp = 3;

range = 70;

state = enemy_states.attack;

pellets = 3;

spread = 35;

offset_direction = 0;

attack_direction = 0;
attack_speed = 1.2*(1 + 0.1 * oCardHolder.counts[card.bad ][bad_cards.enemy_faster]);
move_speed = 0;
/// @description
event_inherited();
can_explode = false;
parent = noone;
hp = 1;

speed = 1;

final_speed = 3*(1 + 0.05 * oCardHolder.counts[card.bad ][bad_cards.enemy_faster]);
acceleration = 0.05;
jerk = 0.003;

state = enemy_states.attack;

direction = 90;
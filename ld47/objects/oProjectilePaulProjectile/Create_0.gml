/// @description
event_inherited();

speed = 1;

final_speed = 5*(1 + 0.05 * oCardHolder.counts[card.bad ][bad_cards.enemy_faster]);
acceleration = 0.05;
jerk = 0.001;

state = enemy_states.attack;

direction = 90;
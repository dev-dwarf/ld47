/// @description
event_inherited();
can_explode = false;
hp = 1;

speed = 5*(1 + 0.05 * oCardHolder.counts[card.bad ][bad_cards.enemy_faster]);

deceleration = 0.1;


state = enemy_states.attack;

image_angle = irandom_range(0,360)
image_index = irandom_range(0,2)
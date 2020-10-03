/// @description
event_inherited();

hp = 3;
i_frames = 0;

hit_damage = 1 + oCardHolder.counts[card.bad ][bad_cards.enemy_damage  ];

enum enemy_states {
	idle, attack, recover, hit, dead
}
state = enemy_states.idle;
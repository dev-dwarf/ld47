/// @description
event_inherited();

hp = 3;
i_frames = 0;

knockback = 0;
knockback_dir = 0;

hit_damage = 1 + 0.8 * oCardHolder.counts[card.bad ][bad_cards.enemy_damage  ];

enum enemy_states {
	idle, attack, recover, hit, dead
}
state = enemy_states.idle;

hit_player = function() {
	oPlayer.hp -= hit_damage;
	oPlayer.i_frames = 60;
	
	
	oCamera.set_shake( 0.5);
	
	oPlayer.knockback = 10;
	oPlayer.knockback_dir = point_direction(x,y,oPlayer.x, oPlayer.y);
	
	if (oPlayer.thorns) {
		hp -= hit_damage * oPlayer.thorns;	
	}
}
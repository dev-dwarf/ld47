/// @description
event_inherited();

with instance_create_depth(x,y,-1000,oObjPari) sprite_index = sTeleport;

can_explode = true;
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
			hp -= hit_damage * oPlayer.thorns;	
		}
		
		if (oCardHolder.counts[card.bad ][bad_cards.enemy_leech	 ] > 0) {
			hp += hit_damage * oCardHolder.counts[card.bad ][bad_cards.enemy_leech	 ] * 0.25;
		}
	}
}
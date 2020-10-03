/// @description
if (i_frames > 0) i_frames -= 2;

var inst = instance_place(x,y,oSword);
if (inst and ((inst.swing) or (oPlayer.state == player_states.dash or oPlayer.dash_not_ready)) and i_frames <= 0) {
	oPlayer.hits_this_time++;
	
	if (state == enemy_states.dead) {
		play_sound(sndSwordHit, 0, false, 1.0 + 0.075 * oPlayer.consecutive_sword_hits, 0.02, 0.2);
	
	} else {
		play_sound(sndSwordHit, 0, false, 1.0 + 0.075 * oPlayer.consecutive_sword_hits, 0.02, 1.0);
		
	}
	
	hp -= oPlayer.hit_damage;
	knockback = 4 + oPlayer.sword_size;
	knockback_dir = point_direction(oPlayer.x, oPlayer.y, x,y);
	
	if (hp <= 0) {
		knockback *= 2;
		state = enemy_states.dead;
		// TODO: enemy death sound
	
	} else {
		i_frames = 10;
		inst.i_frames = 10;
		oCamera.set_shake( 0.1);
		
		if oPlayer.leach > 0 {
			oPlayer.hp += oPlayer.leach*oPlayer.hit_damage;	
		}
	}
}

move(knockback,knockback_dir);
knockback = lerp(knockback, 0, 0.7);
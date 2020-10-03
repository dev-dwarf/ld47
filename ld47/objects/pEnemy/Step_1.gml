/// @description
if (i_frames > 0) i_frames--;

var inst = instance_place(x,y,oSword);
if (inst and ((inst.swing) or (oPlayer.state == player_states.dash or oPlayer.dash_not_ready)) and i_frames <= 0) {
	
	oPlayer.hits_this_time++;
	play_sound(sndSwordHit, 0, false, 1.0 + 0.075 * oPlayer.consecutive_sword_hits, 0.02, 1.0);
	
	hp -= oPlayer.hit_damage;
	
	if oPlayer.leach > 0 {
		oPlayer.hp += oPlayer.leach*oPlayer.hit_damage;	
	}	
	i_frames = 10;
	inst.i_frames = 10;
	oCamera.set_shake( 0.1);
	
	
	
	if (hp == 0) {
		state = enemy_states.dead;
		// TODO: enemy death sound
	
	}
}
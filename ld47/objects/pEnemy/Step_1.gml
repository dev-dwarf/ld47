/// @description
if (i_frames > 0) i_frames--;

if (place_meeting(x,y,oSword) and ((oSword.swing) or (oPlayer.state == player_states.dash or oPlayer.dash_not_ready)) and i_frames <= 0) {
	// TODO: play hit sound	
	hp -= oPlayer.hit_damage;
	
	if oPlayer.leach > 0 {
		oPlayer.hp += oPlayer.leach*oPlayer.hit_damage;	
	}	
	i_frames = 10;
	oCamera.set_shake( 0.1);
	
	if (hp == 0) {
		state = enemy_states.dead;
		// TODO: enemy death sound
	
	}
}
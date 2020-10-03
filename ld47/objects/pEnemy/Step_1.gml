/// @description
if (i_frames > 0) i_frames--;

if (place_meeting(x,y,oSword) and i_frames <= 0) {
	// TODO: play hit sound	
	hp--;
	i_frames = 10;
	
	if (hp == 0) {
		state = enemy_states.dead;
		// TODO: enemy death sound
	
	}
}
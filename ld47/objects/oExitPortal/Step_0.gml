if (spawn_delay > 0) {
	image_xscale = lerp(image_xscale, 1.0, 0.2);
	image_yscale = lerp(image_yscale, 1.0, 0.2);
	spawn_delay--;
	exit;
}


if (place_meeting(x,y,oPlayer)) {
	step_on_delay--;
	
	oPlayer.x = lerp(oPlayer.x, x, 0.2);
	oPlayer.y = lerp(oPlayer.y, y, 0.2);
	oPlayer.state = player_states.freeze;
	
	if (step_on_delay == 0) {
		player = true;
	}
}	
	
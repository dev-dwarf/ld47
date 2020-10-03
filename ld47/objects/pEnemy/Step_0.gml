/// @description

if state != enemy_states.dead and  (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 and oPlayer.dash_state != dash_states.mid) {
	hit_player();
}


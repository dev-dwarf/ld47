/// @description

if (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 and oPlayer.dash_state != dash_states.mid) {
	oPlayer.hp -= hit_damage;
	oPlayer.i_frames = 30;
	
	
	oCamera.set_shake( 0.5);
	
	oPlayer.knockback = 10;
	oPlayer.knockback_dir = point_direction(x,y,oPlayer.x, oPlayer.y);
	
	if (oPlayer.thorns) {
		hp -= hit_damage * oPlayer.thorns;	
	}
}
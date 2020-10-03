/// @description

if (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 and oPlayer.dash_state != dash_states.mid) {
	hit_player();
	instance_destroy();
}

if (place_meeting(x,y,pSolid)) instance_destroy();

if (state == enemy_states.attack) {
	hp = 1;

	image_angle = direction;
	acceleration = approach(acceleration, 1, jerk);
	speed = approach(speed, final_speed*5/4, acceleration);

	if (speed > 1.5 and speed <= final_speed) {
		direction = angle_lerp(direction, point_direction(x,y,oPlayer.x,oPlayer.y), 0.1);	
	}
}

if (state == enemy_states.dead) {
	speed = lerp(speed, 0, 0.3);
	
	if (speed < 0.1) instance_destroy();	
}

/// @description
if (!instance_exists(parent)) instance_destroy();

image_angle = direction;
if (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 and oPlayer.dash_state != dash_states.mid) {
	hit_player();
	instance_destroy();
}

if (state == enemy_states.dead) {
	speed = lerp(speed, 0, 0.3);
	
	if (speed < 0.1) instance_destroy();	
} else {
	if (hp > 1) parent.hp += hp - 1;
		hp = 1;

	if (place_meeting(x,y,pSolid)) instance_destroy();

	speed = approach(speed, 0, deceleration);

	if (speed < 1.0) instance_destroy();
}
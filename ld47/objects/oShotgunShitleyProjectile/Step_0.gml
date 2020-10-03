/// @description
image_angle = direction;
if (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 and oPlayer.dash_state != dash_states.mid) {
	hit_player();
	instance_destroy();
}

if (place_meeting(x,y,pSolid)) instance_destroy();

speed = approach(speed, 0, deceleration);

if (speed < 1.0) instance_destroy();
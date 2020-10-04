var xstep = lengthdir_x(1, direction);
var ystep = lengthdir_y(1, direction);
var view_x = camera_get_view_x(view_camera[0])
var view_y = camera_get_view_y(view_camera[0])

for (var i = 0; i < move_speed; i++) {
	if  (x+xstep < view_x) {
		direction = 180-direction;	
		image_xscale = 0.25; image_yscale = .55;
		break;
	} else if (x+xstep > view_x+DEFAULT_WIDTH) {
		direction = 180-direction;	
		image_xscale = 0.25; image_yscale =  .55;
		break;
	} else if (y+ystep < view_y) {
		direction = -direction;	
		image_yscale = 0.25; image_xscale =  .55;
		break;
	} else if (y+ystep > view_y+DEFAULT_HEIGHT) {
		direction = -direction;
		image_yscale = 0.25; image_xscale =  .55;
		break;
	} else {
		x = (x+xstep);
		y = (y+ystep);
	}
}

if (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 ) {
	oPlayer.hp -= hit_damage*(1+0.5*oCardHolder.counts[card.bad][bad_cards.glass_bones]);
	play_sound(sndPlayerHurt, 0, false, 1.0, 0.04, 1.0);
	oCamera.set_shake( 0.5);
	oPlayer.i_frames = 60;
}
image_xscale = lerp(image_xscale, 0.5, 0.2);
image_yscale = lerp(image_yscale, 0.5, 0.2);

image_angle+=10*sign(dcos(direction));
/// @description
if (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 ) {
	oPlayer.hp -= hit_damage*(1+0.5*oCardHolder.counts[card.bad][bad_cards.glass_bones]);
	
	oCamera.set_shake( 0.5);
	oPlayer.i_frames = 60;
}

var xstep = lengthdir_x(1,direction);
var ystep = lengthdir_y(1,direction);

for (var i = 0; i < move_speed; i++) {
	if  (x+xstep < 0) {
		direction = 180-direction;	
		image_xscale = 0.5; image_yscale = 1.25;
		break;
	} else if (x+xstep > room_width) {
		direction = 180-direction;	
		image_xscale = 0.5; image_yscale = 1.25;
		break;
	} else if (y+ystep < 0) {
		direction = -direction;	
		image_yscale = 0.5; image_xscale = 1.25;
		break;
	} else if (y+ystep > room_height) {
		direction = -direction;
		image_yscale = 0.5; image_xscale = 1.25;
		break;
	} else {
		x = (x+xstep);
		y =	(y+ystep);
	}
}

image_xscale = lerp(image_xscale, 1.0, 0.2);
image_yscale = lerp(image_yscale, 1.0, 0.2);


image_angle = angle_lerp(image_angle, direction, 0.2)
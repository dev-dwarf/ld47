
if (instance_exists(oExitPortal) or (instance_exists(oPlayer) and (oPlayer.state == player_states.death or oPlayer.state == player_states.victory))) {
	image_blend = global.that_one_purple;
	image_speed = 0;
	exit;	
}


var xstep = lengthdir_x(1, direction);
var ystep = lengthdir_y(1, direction);
var view_x = camera_get_view_x(view_camera[0])
var view_y = camera_get_view_y(view_camera[0])

for (var i = 0; i < move_speed; i++) {
	if  (x+xstep < view_x) {
		direction = 180-direction;	
		image_xscale = 0.85; image_yscale = 1.15;
		if (!audio_is_playing(sndMetalClang))
			play_sound(sndMetalClang, 0, false, 1.5, 0.09, 0.4);	
		var xstep = lengthdir_x(1, direction);
		var ystep = lengthdir_y(1, direction);		
		
	} else if (x+xstep > view_x+DEFAULT_WIDTH) {	  
		direction = 180-direction;					  
		image_xscale = 0.85; image_yscale =  1.15;	  
		if (!audio_is_playing(sndMetalClang))
			play_sound(sndMetalClang, 0, false, 1.5, 0.09, 0.4);													 
		var xstep = lengthdir_x(1, direction);
		var ystep = lengthdir_y(1, direction);									 
	} else if (y+ystep < view_y) {					 
		direction = -direction;						 
		image_yscale = 0.85; image_xscale =  1.15;	 
		if (!audio_is_playing(sndMetalClang))
			play_sound(sndMetalClang, 0, false, 1.5, 0.09, 0.4);													 
		var xstep = lengthdir_x(1, direction);
		var ystep = lengthdir_y(1, direction);										  
	} else if (y+ystep > view_y+DEFAULT_HEIGHT) {	  
		direction = -direction;						  
		image_yscale = 0.85; image_xscale =  1.15;	  
		if (!audio_is_playing(sndMetalClang))
			play_sound(sndMetalClang, 0, false, 1.5, 0.09, 0.4);														 
		var xstep = lengthdir_x(1, direction);
		var ystep = lengthdir_y(1, direction);		
	} else {
		x = (x+xstep);
		y = (y+ystep);
	}
}

if (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0) {
	oPlayer.hp -= hit_damage*(+0.5*oCardHolder.counts[card.bad][bad_cards.glass_bones]);
	play_sound(sndPlayerHurt, 0, false, 1.0, 0.04, 1.0);
	oCamera.set_shake( 0.5);
	oPlayer.i_frames = 60;
}
image_xscale = lerp(image_xscale, 1.0, 0.2);
image_yscale = lerp(image_yscale, 1.0, 0.2);

image_angle+=10*sign(dcos(direction));
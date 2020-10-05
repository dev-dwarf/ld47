/// @description
image_angle = direction;
if (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 and oPlayer.dash_state != dash_states.mid) {
	
	if (oPlayer.has_shield) {
		oPlayer.has_shield = false;
		oPlayer.shield_radius = 32;
		oCamera.set_shake( 0.25);
	} else {
		oPlayer.hp -= hit_damage*(1+0.5*oCardHolder.counts[card.bad][bad_cards.glass_bones]);
		play_sound(sndPlayerHurt, 0, false, 1.0, 0.04, 1.0);
		oCamera.set_shake( 0.5);
	}
	oPlayer.i_frames = 60;
	instance_destroy();
}
speed = lerp(speed, 5, 0.5);

image_xscale = lerp(image_xscale, 1.0, 0.2)
image_yscale = lerp(image_yscale, 1.0, 0.2)
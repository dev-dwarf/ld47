/// @description
i_frames = 0;

image_yscale = lerp(image_yscale, 1.0, 0.5);

if (!set_xscale) {
	var inst = noone;
	while (!(inst and inst != first_solid) and image_xscale < 800) {
		inst = instance_place(x,y,pSolid);
		
		if (first_solid == noone and inst != noone) first_solid = inst;
		image_xscale++;	
		
	}
}

life--;
if (life <= 0) {
	image_alpha = approach(image_alpha, 0, 0.25);
	if (image_alpha == 0) instance_destroy();
}

if (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 ) {
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
	oPlayer.knockback = 5;
	oPlayer.knockback_dir = image_angle;
}
/// @description
if (instance_exists(oExitPortal) or (instance_exists(oPlayer) and (oPlayer.state == player_states.death or oPlayer.state == player_states.victory))) {
	image_blend = global.that_one_purple;
	image_speed = 0;
	exit;	
}

if (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 ) {
	oPlayer.hp -= hit_damage*(1+0.5*oCardHolder.counts[card.bad][bad_cards.glass_bones]);
	play_sound(sndPlayerHurt, 0, false, 1.0, 0.04, 1.0);
	oCamera.set_shake( 0.5);
	oPlayer.i_frames = 60;
}
/// @description
if (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0 ) {
	oPlayer.hp -= hit_damage*(1+0.5*oCardHolder.counts[card.bad][bad_cards.glass_bones]);
	
	oCamera.set_shake( 0.5);
	oPlayer.i_frames = 60;
}
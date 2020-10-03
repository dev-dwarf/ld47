/// @description

if (place_meeting(x,y,oPlayer) and oPlayer.i_frames <= 0) {
	oPlayer.hp -= hit_damage;
	oPlayer.i_frames = 30;
}
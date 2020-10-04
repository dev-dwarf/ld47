/// @description
if (instance_exists(oWaveController) and oWaveController.state == wave_states.battle) and
   (instance_exists(oPlayer) and oPlayer.state != player_states.death) {
	image_angle -= 1;
	
}

x =  room_width/2 - oCamera.screenshake_x;
y = room_height/2 - oCamera.screenshake_y;
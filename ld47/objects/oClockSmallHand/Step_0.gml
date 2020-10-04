/// @description
if (instance_exists(oWaveController) and oWaveController.state == wave_states.battle) and
   (instance_exists(oPlayer) and oPlayer.state != player_states.death) and current_time > time_start+1000  {
	image_angle -= 360/60;
	time_start = current_time;
	
}

x =  room_width/2 - oCamera.screenshake_x;
y = room_height/2 - oCamera.screenshake_y;
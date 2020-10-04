/// @description

if (check_p(vk_f)) {
	global.fullscreen = !global.fullscreen;
	window_set_fullscreen(global.fullscreen);
}

// re focus if fullscreened

var focus = window_has_focus();
if (focus != last_focused and global.fullscreen) {
	window_set_fullscreen(focus);
}
last_focused = focus;

if (instance_exists(oPlayer) and instance_exists(oWaveController) and oWaveController.state == wave_states.battle) {
	x = lerp(x, room_width /2 + (oPlayer.x-oPlayer.xstart)*0.06, 0.2);
	y = lerp(y, room_height/2 + (oPlayer.y-oPlayer.ystart)*0.06, 0.2);
} else {
	x = lerp(x, room_width /2, 0.2);
	y = lerp(y, room_height/2, 0.2);
}

var new_width = DEFAULT_WIDTH  ;
var new_height= DEFAULT_HEIGHT ;

new_x = x - new_width/2;
new_y = y - new_height/2;

screenshake = clamp(screenshake, 0, 1)
if (screenshake > 0) {
	var screenshake_amount = screenshake_intensity * (power(screenshake, 1.5));
	screenshake_x = random_range(screenshake_amount/2, screenshake_amount) * choose(-1, 1);
	screenshake_y = random_range(screenshake_amount/2, screenshake_amount) * choose(-1, 1);
	
	if (global.gamepad_connected) {
		gamepad_set_vibration(global.gamepad_slot, screenshake*0.3, screenshake*0.3)	
	}
		
	screenshake -= screenshake_decrease
} else {
	if (global.gamepad_connected) {
		gamepad_set_vibration(global.gamepad_slot, 0, 0)	
	}
}

// set new camera values
camera_set_view_pos(view_camera[0], new_x+screenshake_x, new_y+screenshake_y);
camera_set_view_size(view_camera[0], new_width, new_height);
/// @description

x = room_width/2;
y = room_height/2;


var new_width = DEFAULT_WIDTH  ;
var new_height= DEFAULT_HEIGHT ;

new_x = x - new_width/2;
new_y = y - new_height/2;

screenshake = clamp(screenshake, 0, 1)
if (screenshake > 0) {
	var screenshake_amount = screenshake_intensity * (power(screenshake, 1.5));
	new_x += random_range(screenshake_amount/2, screenshake_amount) * choose(-1, 1);
	new_y += random_range(screenshake_amount/2, screenshake_amount) * choose(-1, 1);
	
	if (global.gamepad_connected) {
		gamepad_set_vibration(global.gamepad_slot, screenshake, screenshake)	
	}
		
	screenshake -= screenshake_decrease
} else {
	if (global.gamepad_connected) {
		gamepad_set_vibration(global.gamepad_slot, 0, 0)	
	}
}

// set new camera values
camera_set_view_pos(view_camera[0], new_x, new_y);
camera_set_view_size(view_camera[0], new_width, new_height);
/// @description
if (view_camera[0] > 0) {
	view_enabled = true;
	view_visible[0] = true;
	view_camera[0] = camera_create_view(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT, 0, -1, -1, -1, -1, -1);
}

scale = 3;
window_x = (display_get_width()  - DEFAULT_WIDTH  * scale) / 2; //get centered coords
window_y = (display_get_height() - DEFAULT_HEIGHT * scale) / 2;

surface_resize(application_surface,DEFAULT_WIDTH,DEFAULT_HEIGHT);
display_set_gui_size(DEFAULT_WIDTH*scale,DEFAULT_HEIGHT*scale);

global.gui_scale = scale;
if (!global.set_window) {
	window_set_rectangle(window_x, window_y, DEFAULT_WIDTH*scale,DEFAULT_HEIGHT*scale); // centers window
	global.set_window = true;
}

#region screenshake
screenshake = 1;
screenshake_intensity = 6;
screenshake_decrease = 0.03;

#endregion

function set_shake(shake) {
	if (screenshake < shake) {
		screenshake = shake;	
	}
}
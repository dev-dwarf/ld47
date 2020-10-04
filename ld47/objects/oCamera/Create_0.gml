/// @description
if (view_camera[0] > 0) {
	view_enabled = true;
	view_visible[0] = true;
	view_camera[0] = camera_create_view(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT, 0, -1, -1, -1, -1, -1);
}

scale = 3;
subpixel_level = 1;

alarm[0] = 1;


#region screenshake
screenshake = 1;
screenshake_intensity = 6;
screenshake_decrease = 0.03;

screenshake_x = 0;
screenshake_y = 0;

#endregion

function set_shake(shake) {
	if (screenshake < shake) {
		screenshake = shake;	
	}
}
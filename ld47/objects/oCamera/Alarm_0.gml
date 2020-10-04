/// @description
window_x = (display_get_width()  - DEFAULT_WIDTH  * scale) / 2; //get centered coords
window_y = (display_get_height() - DEFAULT_HEIGHT * scale) / 2;

surface_resize(application_surface,DEFAULT_WIDTH*subpixel_level,DEFAULT_HEIGHT*subpixel_level);
display_set_gui_size(DEFAULT_WIDTH*scale,DEFAULT_HEIGHT*scale);

global.gui_scale = scale;
if (!global.set_window) {
	window_set_rectangle(window_x, window_y, DEFAULT_WIDTH*scale,DEFAULT_HEIGHT*scale); // centers window
	global.set_window = true;
}

window_set_fullscreen(global.fullscreen)
